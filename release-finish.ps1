# release-finish.ps1
# Script para finalizar o fluxo de release localmente após aprovação do PR na Main

# Verifica se está numa branch de release ou hotfix
$currentBranch = git branch --show-current
if (-not ($currentBranch.StartsWith("release/") -or $currentBranch.StartsWith("hotfix/"))) {
    Write-Host "Este script deve ser executado a partir de uma branch de release (release/*) ou hotfix (hotfix/*)." -ForegroundColor Red
    exit 1
}

Write-Host "Finalizando release/hotfix $currentBranch..." -ForegroundColor Cyan

# 1. Atualizar Main (garantir que temos o merge da PR)
Write-Host "1. Atualizando branch main..." -ForegroundColor Green
git checkout main
git pull origin main

# 2. Atualizar Develop (Back-merge)
# No Git Flow, a develop também precisa receber as alterações da release
Write-Host "2. Atualizando branch develop..." -ForegroundColor Green
git checkout develop
git pull origin develop
git merge main # Traz as alterações consolidadas da main para develop
if ($LASTEXITCODE -ne 0) {
    Write-Error "Conflito ao mergear main em develop. Resolva manualmente."
    exit $LASTEXITCODE
}
git push origin develop

# 3. Limpeza
Write-Host "3. Removendo branch de release local..." -ForegroundColor Green
git branch -d $currentBranch

# Opcional: Remover remota também, se já não foi removida pelo merge do PR
Write-Host "Tentando remover branch remota (pode falhar se já não existir)..." -ForegroundColor Yellow
git push origin --delete $currentBranch 2>$null

Write-Host "Release finalizada com sucesso! Ambiente limpo e atualizado." -ForegroundColor Cyan

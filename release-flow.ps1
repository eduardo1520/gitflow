# release-flow.ps1
# Script para automatizar o fluxo de release: Push Release -> Merge Staging -> Push Staging -> Criar PR para Main

$currentBranch = git branch --show-current
if (-not ($currentBranch.StartsWith("release/") -or $currentBranch.StartsWith("hotfix/"))) {
    Write-Host "Este script deve ser executado a partir de uma branch de release (release/*) ou hotfix (hotfix/*)." -ForegroundColor Red
    exit 1
}

Write-Host "Iniciando fluxo de release/hotfix para a branch: $currentBranch" -ForegroundColor Cyan

# 1. Push da branch de release atual
Write-Host "1. Enviando $currentBranch para o remote..." -ForegroundColor Green
git push origin $currentBranch
if ($LASTEXITCODE -ne 0) { Write-Error "Falha ao dar push na release."; exit $LASTEXITCODE }

# 2. Checkout e atualização da staging
Write-Host "2. Atualizando branch staging..." -ForegroundColor Green
git checkout staging
git pull origin staging

# 3. Merge da release na staging
Write-Host "3. Mergeando $currentBranch em staging..." -ForegroundColor Green
git merge $currentBranch
if ($LASTEXITCODE -ne 0) { 
    Write-Error "Conflito de merge detectado. Resolva os conflitos e continue manualmente."
    exit $LASTEXITCODE 
}

# 4. Push da staging
Write-Host "4. Enviando staging para o remote..." -ForegroundColor Green
git push origin staging
if ($LASTEXITCODE -ne 0) { Write-Error "Falha ao dar push na staging."; exit $LASTEXITCODE }

# 5. Criar Pull Request para Main
Write-Host "5. Criando Pull Request para main..." -ForegroundColor Green
# Verifica se já existe PR
$existingPr = gh pr list --head $currentBranch --base main --json url --jq '.[0].url'
if ($existingPr) {
    Write-Host "PR já existe: $existingPr" -ForegroundColor Yellow
} else {
    gh pr create --base main --head $currentBranch --title "Release $currentBranch" --body "Automated release PR from $currentBranch"
}

# 6. Voltar para a branch original
Write-Host "6. Voltando para $currentBranch..." -ForegroundColor Green
git checkout $currentBranch

Write-Host "Fluxo de release concluído com sucesso!" -ForegroundColor Cyan

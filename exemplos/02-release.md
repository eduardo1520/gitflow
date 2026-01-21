# Exemplo: Criando uma Release

Este exemplo mostra como preparar e lançar uma nova versão usando GitFlow.

## Cenário

Você tem várias features prontas em `develop` e quer lançar a versão 1.2.0.

## Passo a Passo

### 1. Criar Release Branch

```bash
git flow release start 1.2.0
```

### 2. Atualizar Versão e Changelog

```bash
# Criar/atualizar arquivo VERSION
echo "1.2.0" > VERSION
git add VERSION
git commit -m "chore: bump version to 1.2.0"

# Atualizar CHANGELOG.md
cat >> CHANGELOG.md << 'EOF'

## [1.2.0] - 2024-01-21

### Adicionado
- Sistema de autenticação de usuários
- Dashboard de administração
- API de relatórios

### Corrigido
- Bug na validação de emails
- Problema de performance no carregamento

EOF

git add CHANGELOG.md
git commit -m "docs: atualiza changelog para v1.2.0"
```

### 3. Testes Finais

```bash
# Rodar testes completos
npm test

# Rodar build
npm run build

# Testar manualmente
npm start
```

### 4. Finalizar Release

```bash
git flow release finish 1.2.0
```

Você será solicitado a:
1. Escrever mensagem da tag (ex: "Release 1.2.0")
2. Confirmar merge em develop
3. Confirmar merge em main

### 5. Enviar Tudo

```bash
# Enviar develop
git push origin develop

# Enviar main
git push origin main

# Enviar tags
git push origin --tags
```

## Comandos Resumidos

```bash
# 1. Criar release
git flow release start 1.2.0

# 2. Atualizar versão
echo "1.2.0" > VERSION
git commit -am "chore: bump version to 1.2.0"

# 3. Atualizar changelog
# Editar CHANGELOG.md
git commit -am "docs: atualiza changelog"

# 4. Finalizar
git flow release finish 1.2.0

# 5. Enviar
git push origin develop main --tags
```

## Versionamento Semântico

```
1.2.0 → 1.2.1  (PATCH: correções de bugs)
1.2.0 → 1.3.0  (MINOR: novas features)
1.2.0 → 2.0.0  (MAJOR: breaking changes)
```

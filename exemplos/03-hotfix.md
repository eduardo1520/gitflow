# Exemplo: Aplicando um Hotfix

Este exemplo mostra como corrigir um bug crítico em produção usando hotfix.

## Cenário

Foi descoberto um bug crítico de segurança na versão 1.2.0 em produção.
Você precisa corrigir urgentemente.

## Passo a Passo

### 1. Criar Hotfix Branch

```bash
git flow hotfix start 1.2.1
```

### 2. Corrigir o Bug

```bash
# Exemplo: Corrigir validação de input
cat > security.js << 'EOF'
function sanitizeInput(input) {
    // Prevenir XSS
    return input
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#x27;')
        .replace(/\//g, '&#x2F;');
}

module.exports = { sanitizeInput };
EOF

git add security.js
git commit -m "fix: adiciona sanitização de input para prevenir XSS"
```

### 3. Atualizar Versão

```bash
echo "1.2.1" > VERSION
git add VERSION
git commit -m "chore: bump version to 1.2.1"
```

### 4. Testar a Correção

```bash
# Rodar testes
npm test

# Testar manualmente a correção
npm start
```

### 5. Finalizar Hotfix

```bash
git flow hotfix finish 1.2.1
```

### 6. Enviar Tudo

```bash
git push origin develop
git push origin main
git push origin --tags
```

### 7. Deploy em Produção

```bash
# Após push, fazer deploy da tag 1.2.1
git checkout 1.2.1
# ... processo de deploy ...
```

## Comandos Resumidos

```bash
# 1. Criar hotfix
git flow hotfix start 1.2.1

# 2. Corrigir bug
# Editar arquivos
git commit -am "fix: corrige bug crítico"

# 3. Atualizar versão
echo "1.2.1" > VERSION
git commit -am "chore: bump version to 1.2.1"

# 4. Finalizar
git flow hotfix finish 1.2.1

# 5. Enviar
git push origin develop main --tags
```

## Quando Usar Hotfix?

✅ **Use hotfix para:**
- Bugs críticos em produção
- Vulnerabilidades de segurança
- Problemas que afetam usuários agora

❌ **NÃO use hotfix para:**
- Features novas
- Melhorias de performance
- Refatorações
- Bugs não críticos

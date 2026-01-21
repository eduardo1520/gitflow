# Melhores Práticas GitFlow

## 📋 Sumário

1. [Estrutura de Branches](#estrutura-de-branches)
2. [Commits](#commits)
3. [Code Review](#code-review)
4. [Testes](#testes)
5. [Documentação](#documentação)
6. [Segurança](#segurança)

## Estrutura de Branches

### ✅ Faça

- **Mantenha `main` sempre deployável** - Cada commit em main deve ser uma versão estável
- **Use `develop` para integração** - Todas as features devem ser integradas aqui primeiro
- **Crie branches pequenas e focadas** - Uma feature por branch
- **Nomeie branches de forma descritiva** - Use `feature/user-authentication` ao invés de `feature/fix`
- **Delete branches após merge** - Mantenha o repositório limpo

### ❌ Evite

- **Commits diretos em `main` ou `develop`** - Sempre use branches de feature
- **Branches de longa duração** - Integre frequentemente para evitar conflitos
- **Múltiplas features em uma branch** - Dificulta code review e rollback
- **Nomes genéricos** - `feature/fix`, `feature/update` não dizem nada

### Exemplo de Nomenclatura

```
✅ Bom:
feature/user-authentication
feature/payment-integration
feature/dashboard-analytics
hotfix/security-patch-xss
release/1.2.0

❌ Ruim:
feature/fix
feature/stuff
feature/updates
hotfix/bug
release/new-version
```

## Commits

### Conventional Commits

Siga o padrão [Conventional Commits](https://www.conventionalcommits.org/pt-br/):

```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[rodapé(s) opcional(is)]
```

### Tipos de Commit

- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Documentação
- `style:` Formatação (não afeta o código)
- `refactor:` Refatoração
- `perf:` Melhoria de performance
- `test:` Testes
- `build:` Sistema de build
- `ci:` Integração contínua
- `chore:` Tarefas gerais

### ✅ Bons Commits

```bash
feat: adiciona autenticação OAuth2
fix: corrige validação de email em lowercase
docs: atualiza README com instruções de instalação
refactor: extrai lógica de validação para classe separada
test: adiciona testes unitários para UserService
perf: otimiza query de busca de usuários
```

### ❌ Commits Ruins

```bash
fix bug
update
changes
wip
asdf
fixed stuff
```

### Regras para Commits

1. **Use o imperativo** - "adiciona" não "adicionado"
2. **Primeira linha com 50 caracteres** - Descrição curta
3. **Corpo com 72 caracteres por linha** - Se necessário
4. **Uma mudança lógica por commit** - Facilita reverter
5. **Teste antes de commitar** - Não quebre a build

### Exemplo Completo

```bash
feat: adiciona sistema de notificações por email

Implementa envio de emails usando SendGrid para:
- Confirmação de cadastro
- Recuperação de senha
- Notificações de atividade

Inclui templates HTML responsivos e testes unitários.

Refs: #123
```

## Code Review

### Antes de Submeter PR

- [ ] Código funciona localmente
- [ ] Todos os testes passam
- [ ] Código segue style guide do projeto
- [ ] Documentação atualizada
- [ ] Commits bem organizados
- [ ] Branch atualizada com develop

### Durante Code Review

#### Como Autor

- **Seja receptivo** - Feedback é para melhorar o código
- **Responda prontamente** - Não deixe PRs parados
- **Explique decisões** - Justifique escolhas técnicas
- **Faça mudanças solicitadas** - Ou argumente construtivamente

#### Como Revisor

- **Seja construtivo** - Sugira melhorias, não critique
- **Explique o porquê** - Não só "está errado"
- **Seja específico** - Aponte linha e sugira solução
- **Elogie bom código** - Reconheça trabalho bem feito

### Checklist de Review

- [ ] Código faz o que deveria fazer?
- [ ] Código é legível e manutenível?
- [ ] Há testes adequados?
- [ ] Há vulnerabilidades de segurança?
- [ ] Performance é adequada?
- [ ] Documentação está correta?
- [ ] Sem código comentado ou debug?

## Testes

### Pirâmide de Testes

```
        /\
       /  \      E2E (poucos)
      /____\
     /      \    Integração (alguns)
    /________\
   /          \  Unitários (muitos)
  /____________\
```

### ✅ Faça

- **Teste antes de fazer PR** - Não quebre a build
- **Escreva testes para bugs** - Previna regressão
- **Teste casos extremos** - Null, vazio, muito grande
- **Mantenha testes rápidos** - Especialmente unitários
- **Teste features novas** - Cobertura adequada

### ❌ Evite

- **Commitar código quebrado** - Sempre rode testes antes
- **Depender de ordem de execução** - Testes devem ser independentes
- **Testes flaky** - Que às vezes passam, às vezes falham
- **Mock excessivo** - Teste comportamento real quando possível

## Documentação

### O que Documentar

1. **README.md** - Como usar o projeto
2. **CONTRIBUTING.md** - Como contribuir
3. **CHANGELOG.md** - O que mudou em cada versão
4. **API docs** - Endpoints, parâmetros, respostas
5. **Código** - Comentários quando necessário

### README.md Ideal

```markdown
# Nome do Projeto

Breve descrição do que o projeto faz.

## Instalação

Passos claros para instalar.

## Uso

Exemplos de como usar.

## Desenvolvimento

Como contribuir, rodar testes, etc.

## Licença

Tipo de licença.
```

### CHANGELOG.md

Use [Keep a Changelog](https://keepachangelog.com/pt-BR/):

```markdown
# Changelog

## [1.1.0] - 2024-01-15

### Added
- Nova funcionalidade X
- Suporte para Y

### Changed
- Melhorada performance de Z

### Fixed
- Corrigido bug em W

## [1.0.0] - 2024-01-01

### Added
- Versão inicial
```

### Comentários no Código

```javascript
// ✅ Bom - explica o PORQUÊ
// Usando setTimeout para evitar race condition com o banco
setTimeout(() => saveData(), 100);

// ❌ Ruim - explica o QUE (óbvio)
// Incrementa contador
counter++;

// ✅ Bom - documenta comportamento não óbvio
/**
 * Calcula o hash SHA-256 do arquivo.
 * Nota: Para arquivos > 100MB, usa streaming para evitar
 * estouro de memória.
 */
function hashFile(path) { ... }
```

## Segurança

### ✅ Faça

- **Nunca commite secrets** - Senhas, API keys, tokens
- **Use .gitignore** - Para arquivos sensíveis
- **Valide entrada** - Sempre sanitize input do usuário
- **Use HTTPS** - Para comunicação segura
- **Mantenha dependências atualizadas** - Patches de segurança

### ❌ Evite

- **Senhas em código** - Use variáveis de ambiente
- **SQL injection** - Use prepared statements
- **XSS** - Escape output HTML
- **Secrets no histórico** - Se commitou, mude a senha
- **Dependências desatualizadas** - Vulnerabilidades conhecidas

### Checklist de Segurança

```bash
# Verificar secrets no código
git diff develop | grep -i "password\|api_key\|secret"

# Escanear dependências
npm audit  # Node.js
pip-audit  # Python
bundle audit  # Ruby

# Remover arquivo do histórico (se commitou secret)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch arquivo-secreto" \
  --prune-empty --tag-name-filter cat -- --all
```

### .env Template

```bash
# .env.example - Commite este arquivo
DATABASE_URL=postgres://localhost/mydb
API_KEY=your_api_key_here
SECRET_KEY=your_secret_key_here

# .env - NÃO commite (adicione ao .gitignore)
DATABASE_URL=postgres://user:pass@localhost/mydb
API_KEY=sk_live_abc123...
SECRET_KEY=supersecretkey123...
```

## Ferramentas Úteis

### Pre-commit Hooks

```bash
# .git/hooks/pre-commit
#!/bin/bash

# Rodar linter
npm run lint

# Rodar testes
npm test

# Verificar secrets
if git diff --cached | grep -qi "password\|api_key"; then
    echo "❌ Possível secret detectado!"
    exit 1
fi

echo "✅ Pre-commit checks passed"
```

### Git Aliases

```bash
# ~/.gitconfig
[alias]
    st = status -s
    co = checkout
    br = branch
    ci = commit
    lg = log --graph --oneline --all --decorate
    last = log -1 HEAD
    unstage = reset HEAD --
```

## Resumo das Melhores Práticas

1. ✅ Use branches para tudo
2. ✅ Commits pequenos e descritivos
3. ✅ Teste antes de fazer PR
4. ✅ Code review em tudo
5. ✅ Documente mudanças importantes
6. ✅ Nunca commite secrets
7. ✅ Mantenha dependências atualizadas
8. ✅ Delete branches após merge
9. ✅ Use conventional commits
10. ✅ Mantenha `main` sempre deployável

---

**Lembre-se:** Essas práticas servem para manter o código limpo, seguro e fácil de manter. Siga-as e seu time agradecerá!

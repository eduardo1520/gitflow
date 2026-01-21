# 📖 GitFlow - Cartão de Referência Rápida

## Comandos Básicos

| Ação | Comando |
|------|---------|
| Inicializar GitFlow | `git flow init` |
| Ver configuração | `git flow config` |

## Features (Funcionalidades)

| Ação | Comando |
|------|---------|
| Criar feature | `git flow feature start <nome>` |
| Listar features | `git flow feature list` |
| Publicar feature | `git flow feature publish <nome>` |
| Baixar feature | `git flow feature pull origin <nome>` |
| Finalizar feature | `git flow feature finish <nome>` |
| Deletar feature | `git flow feature delete <nome>` |

## Releases (Versões)

| Ação | Comando |
|------|---------|
| Criar release | `git flow release start <versão>` |
| Listar releases | `git flow release list` |
| Publicar release | `git flow release publish <versão>` |
| Finalizar release | `git flow release finish <versão>` |

## Hotfixes (Correções Urgentes)

| Ação | Comando |
|------|---------|
| Criar hotfix | `git flow hotfix start <versão>` |
| Listar hotfixes | `git flow hotfix list` |
| Finalizar hotfix | `git flow hotfix finish <versão>` |

## Fluxo de Trabalho Típico

### 1. Nova Feature

```bash
git checkout develop
git pull origin develop
git flow feature start minha-feature
# ... desenvolver ...
git add .
git commit -m "feat: adiciona funcionalidade X"
git flow feature finish minha-feature
git push origin develop
```

### 2. Nova Release

```bash
git flow release start 1.0.0
# ... ajustes finais ...
git commit -am "chore: bump version to 1.0.0"
git flow release finish 1.0.0
git push origin develop main --tags
```

### 3. Hotfix Urgente

```bash
git flow hotfix start 1.0.1
# ... corrigir bug ...
git commit -am "fix: corrige bug crítico"
git flow hotfix finish 1.0.1
git push origin develop main --tags
```

## Branches

| Branch | Propósito | Ramifica de | Merge em |
|--------|-----------|-------------|----------|
| `main` | Produção | - | - |
| `develop` | Desenvolvimento | `main` | `main` |
| `feature/*` | Novas funcionalidades | `develop` | `develop` |
| `release/*` | Preparar release | `develop` | `develop` + `main` |
| `hotfix/*` | Correções urgentes | `main` | `develop` + `main` |

## Conventional Commits

| Tipo | Uso | Exemplo |
|------|-----|---------|
| `feat:` | Nova funcionalidade | `feat: adiciona login OAuth` |
| `fix:` | Correção de bug | `fix: corrige validação email` |
| `docs:` | Documentação | `docs: atualiza README` |
| `style:` | Formatação | `style: corrige indentação` |
| `refactor:` | Refatoração | `refactor: simplifica função X` |
| `test:` | Testes | `test: adiciona teste unitário` |
| `chore:` | Manutenção | `chore: atualiza dependências` |

## Versionamento Semântico

```
MAJOR.MINOR.PATCH

1.0.0 → 1.0.1  (PATCH: bug fixes)
1.0.1 → 1.1.0  (MINOR: nova feature)
1.1.0 → 2.0.0  (MAJOR: breaking change)
```

## Git Úteis

| Ação | Comando |
|------|---------|
| Status | `git status` |
| Log visual | `git log --graph --oneline --all` |
| Ver branches | `git branch -a` |
| Atualizar branch | `git pull origin <branch>` |
| Ver diferenças | `git diff <branch1>..<branch2>` |
| Desfazer commit | `git reset --soft HEAD~1` |
| Salvar trabalho | `git stash` |
| Recuperar trabalho | `git stash pop` |
| Deletar branch local | `git branch -D <branch>` |
| Deletar branch remota | `git push origin --delete <branch>` |

## Troubleshooting

### Problema: Commitei na branch errada

```bash
git log  # copiar SHA do commit
git checkout branch-correta
git cherry-pick <SHA>
git checkout branch-errada
git reset --hard HEAD~1
```

### Problema: Preciso mudar de feature

```bash
git stash
git checkout outra-feature
# trabalhar...
git checkout feature-original
git stash pop
```

### Problema: Conflitos ao fazer merge

```bash
# Resolver conflitos nos arquivos
git add .
git commit -m "fix: resolve conflitos"
```

### Problema: Quero desfazer último commit

```bash
# Manter mudanças
git reset --soft HEAD~1

# Descartar mudanças
git reset --hard HEAD~1
```

## Regras de Ouro

1. ✅ **Nunca** commite direto em `main` ou `develop`
2. ✅ **Sempre** crie uma branch para mudanças
3. ✅ **Sempre** teste antes de finalizar feature
4. ✅ **Sempre** atualize `develop` antes de criar feature
5. ✅ **Sempre** delete branches após merge
6. ✅ **Nunca** commite secrets (senhas, API keys)
7. ✅ **Sempre** use mensagens descritivas
8. ✅ **Sempre** faça commits pequenos e focados

## Recursos

- 📚 [README Completo](README.md)
- 🚀 [Guia Rápido](GUIA-RAPIDO.md)
- ⭐ [Melhores Práticas](MELHORES-PRATICAS.md)
- 🛠️ [Script Auxiliar](gitflow-helper.sh)

---

**💡 Dica:** Mantenha este cartão sempre à mão para consultas rápidas!

# Guia Rápido GitFlow

## Comandos Essenciais

### Inicialização
```bash
git flow init
```

### Features
```bash
# Criar
git flow feature start <nome>

# Publicar (compartilhar com time)
git flow feature publish <nome>

# Baixar feature de outro desenvolvedor
git flow feature pull origin <nome>

# Finalizar
git flow feature finish <nome>
```

### Releases
```bash
# Criar
git flow release start <versão>

# Publicar
git flow release publish <versão>

# Finalizar
git flow release finish <versão>
```

### Hotfixes
```bash
# Criar
git flow hotfix start <versão>

# Finalizar
git flow hotfix finish <versão>
```

## Fluxo de Trabalho Diário

### Começar um novo dia
```bash
git checkout develop
git pull origin develop
```

### Trabalhar em uma feature
```bash
# Criar a feature
git flow feature start minha-feature

# Fazer mudanças
git add .
git commit -m "feat: descrição da mudança"

# Publicar para colaboração (opcional)
git flow feature publish minha-feature

# Finalizar quando pronto
git flow feature finish minha-feature
git push origin develop
```

### Preparar uma release
```bash
# Criar release
git flow release start 1.2.0

# Fazer ajustes finais
# Atualizar VERSION, CHANGELOG, etc.
git commit -am "chore: prepare release 1.2.0"

# Finalizar
git flow release finish 1.2.0

# Enviar tudo
git push origin develop
git push origin main
git push origin --tags
```

### Corrigir bug urgente em produção
```bash
# Criar hotfix
git flow hotfix start 1.2.1

# Corrigir o bug
git commit -am "fix: corrige problema crítico"

# Finalizar
git flow hotfix finish 1.2.1

# Enviar tudo
git push origin develop
git push origin main
git push origin --tags
```

## Boas Práticas

1. **Sempre** trabalhe em branches separadas (features)
2. **Nunca** faça commit direto em `main` ou `develop`
3. **Mantenha** suas branches atualizadas com `develop`
4. **Delete** branches após finalizar
5. **Use** mensagens de commit descritivas
6. **Teste** antes de finalizar features

## Mensagens de Commit

Use o padrão Conventional Commits:

```bash
feat: adiciona nova funcionalidade
fix: corrige um bug
docs: atualiza documentação
style: formatação, ponto e vírgula, etc
refactor: refatoração de código
test: adiciona testes
chore: atualiza tarefas de build, configurações, etc
```

## Resolução de Conflitos

```bash
# Atualizar sua branch com develop
git checkout feature/minha-feature
git merge develop

# Resolver conflitos
# Editar arquivos conflitantes
git add .
git commit -m "fix: resolve conflitos com develop"
```

## Versionamento Semântico

```
MAJOR.MINOR.PATCH

1.0.0 → 1.0.1  (patch: bug fixes)
1.0.1 → 1.1.0  (minor: nova feature compatível)
1.1.0 → 2.0.0  (major: breaking changes)
```

## Atalhos Úteis

```bash
# Ver histórico visual
git log --graph --oneline --all

# Ver branches
git branch -a

# Deletar branch local
git branch -D nome-da-branch

# Deletar branch remota
git push origin --delete nome-da-branch

# Ver diferenças entre branches
git diff develop..feature/minha-feature

# Desfazer último commit (mantendo mudanças)
git reset --soft HEAD~1

# Ver status resumido
git status -s
```

## Problemas Comuns

### Esqueci de criar uma feature branch
```bash
# Criar branch com mudanças atuais
git stash
git flow feature start nome-da-feature
git stash pop
```

### Preciso mudar de feature no meio do trabalho
```bash
# Salvar trabalho atual
git stash

# Mudar de branch
git checkout outra-feature

# Voltar e recuperar trabalho
git checkout minha-feature
git stash pop
```

### Commitei na branch errada
```bash
# Mover commit para outra branch
git log  # copiar SHA do commit
git checkout branch-correta
git cherry-pick <SHA>
git checkout branch-errada
git reset --hard HEAD~1
```

## Recursos

- [Documentação Completa](README.md)
- [Script Auxiliar](gitflow-helper.sh)
- [GitFlow Original](https://nvie.com/posts/a-successful-git-branching-model/)

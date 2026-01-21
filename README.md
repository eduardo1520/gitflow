# GitFlow - Guia e Ferramentas de Auxílio

Este projeto tem a intenção de ajudar o desenvolvedor com o GitFlow, fornecendo documentação completa, scripts auxiliares e melhores práticas.

## 📚 Índice

- [O que é GitFlow?](#o-que-é-gitflow)
- [Instalação](#instalação)
- [Branches Principais](#branches-principais)
- [Tipos de Branches](#tipos-de-branches)
- [Fluxo de Trabalho](#fluxo-de-trabalho)
- [Comandos Úteis](#comandos-úteis)
- [Script Auxiliar](#script-auxiliar)
- [Melhores Práticas](#melhores-práticas)
- [Exemplos](#exemplos)

## O que é GitFlow?

GitFlow é um modelo de ramificação (branching model) para Git, criado por Vincent Driessen. Ele define um conjunto rigoroso de regras sobre como as branches devem ser criadas e mescladas, tornando-se especialmente útil para projetos com releases programados.

### Vantagens do GitFlow

- ✅ Organização clara do código
- ✅ Desenvolvimento paralelo facilitado
- ✅ Releases bem estruturados
- ✅ Correções de emergência (hotfixes) isoladas
- ✅ Histórico limpo e rastreável

## Instalação

### Git Flow AVH Edition (Recomendado)

```bash
# Ubuntu/Debian
sudo apt-get install git-flow

# macOS
brew install git-flow-avh

# Windows (Git Bash)
# Baixe de: https://github.com/petervanderdoes/gitflow-avh
```

### Inicializar GitFlow no Projeto

```bash
git flow init
```

Aceite os nomes padrão ou personalize conforme necessário:
- Branch de produção: `main` ou `master`
- Branch de desenvolvimento: `develop`
- Prefixos: `feature/`, `release/`, `hotfix/`, `support/`

## Branches Principais

### 🌳 Main/Master
- Contém o código de **produção**
- Sempre estável
- Cada commit representa uma versão de release
- **Nunca** fazer commits diretos aqui

### 🔧 Develop
- Branch de **desenvolvimento**
- Integração de todas as features
- Base para criação de novas features
- Código mais recente em desenvolvimento

## Tipos de Branches

### 🎨 Feature Branches (`feature/*`)
**Propósito:** Desenvolvimento de novas funcionalidades

```bash
# Criar feature
git flow feature start nome-da-feature

# Finalizar feature
git flow feature finish nome-da-feature
```

**Características:**
- Ramifica de: `develop`
- Merge em: `develop`
- Nomenclatura: `feature/login`, `feature/payment-integration`

### 🚀 Release Branches (`release/*`)
**Propósito:** Preparação para uma nova versão de produção

```bash
# Criar release
git flow release start 1.0.0

# Finalizar release
git flow release finish 1.0.0
```

**Características:**
- Ramifica de: `develop`
- Merge em: `develop` e `main`
- Nomenclatura: `release/1.0.0`, `release/2.1.0`
- Permite pequenos ajustes e correções de bugs
- Não adicionar novas features

### 🔥 Hotfix Branches (`hotfix/*`)
**Propósito:** Correções urgentes em produção

```bash
# Criar hotfix
git flow hotfix start 1.0.1

# Finalizar hotfix
git flow hotfix finish 1.0.1
```

**Características:**
- Ramifica de: `main`
- Merge em: `develop` e `main`
- Nomenclatura: `hotfix/1.0.1`, `hotfix/security-patch`
- Para bugs críticos em produção

### 🛡️ Support Branches (`support/*`)
**Propósito:** Suporte a versões antigas de produção

```bash
# Criar support
git flow support start 1.x support/1.x
```

**Características:**
- Ramifica de: `main` (tag específica)
- Para manter versões antigas

## Fluxo de Trabalho

### 1️⃣ Desenvolvendo uma Nova Feature

```bash
# 1. Atualizar develop
git checkout develop
git pull origin develop

# 2. Criar feature branch
git flow feature start minha-feature

# 3. Desenvolver e commitar
git add .
git commit -m "feat: adiciona nova funcionalidade"

# 4. Publicar feature (opcional, para colaboração)
git flow feature publish minha-feature

# 5. Finalizar feature
git flow feature finish minha-feature

# 6. Enviar develop atualizado
git push origin develop
```

### 2️⃣ Criando uma Release

```bash
# 1. Criar release branch
git flow release start 1.2.0

# 2. Fazer ajustes finais e atualizar versão
# Editar arquivos de versão, CHANGELOG, etc.
git commit -am "chore: bump version to 1.2.0"

# 3. Finalizar release
git flow release finish 1.2.0

# 4. Enviar mudanças
git push origin develop
git push origin main
git push origin --tags
```

### 3️⃣ Aplicando um Hotfix

```bash
# 1. Criar hotfix branch
git flow hotfix start 1.2.1

# 2. Corrigir o bug
git commit -am "fix: corrige bug crítico em produção"

# 3. Finalizar hotfix
git flow hotfix finish 1.2.1

# 4. Enviar mudanças
git push origin develop
git push origin main
git push origin --tags
```

## Comandos Úteis

### Comandos GitFlow Básicos

```bash
# Listar features
git flow feature list

# Listar releases
git flow release list

# Listar hotfixes
git flow hotfix list

# Deletar feature remotamente
git push origin --delete feature/nome-da-feature

# Ver configuração do GitFlow
git flow config
```

### Comandos Git Úteis

```bash
# Ver histórico visual
git log --graph --oneline --all --decorate

# Ver diferenças
git diff develop..feature/minha-feature

# Ver status de todas as branches
git branch -a

# Sincronizar com remoto
git fetch --all --prune
```

## Scripts Auxiliares

Este projeto inclui dois scripts para facilitar operações comuns do GitFlow.

### 🚀 gitflow-helper.sh (Requer git-flow instalado)

Script completo que usa comandos `git flow`. Requer git-flow instalado.

```bash
# Tornar o script executável
chmod +x gitflow-helper.sh

# Executar o script
./gitflow-helper.sh
```

**Funcionalidades:**
- Menu interativo colorido
- Gerenciar features, releases e hotfixes
- Visualizar status do projeto
- Sincronizar branches
- Ajuda integrada

### 📝 gitflow-manual.sh (Usa Git nativo)

Script alternativo que usa apenas comandos Git nativos. Não requer git-flow.

```bash
# Tornar o script executável
chmod +x gitflow-manual.sh

# Executar o script
./gitflow-manual.sh
```

**Funcionalidades:**
- Criar e finalizar features
- Criar e finalizar releases
- Criar e finalizar hotfixes
- Visualizar status
- Comandos Git equivalentes

## Melhores Práticas

### ✅ Commits

- Use commits semânticos (Conventional Commits)
  - `feat:` nova funcionalidade
  - `fix:` correção de bug
  - `docs:` documentação
  - `style:` formatação
  - `refactor:` refatoração
  - `test:` testes
  - `chore:` tarefas de manutenção

```bash
git commit -m "feat: adiciona autenticação OAuth"
git commit -m "fix: corrige validação de email"
git commit -m "docs: atualiza README com exemplos"
```

### ✅ Branches

- Mantenha branches pequenas e focadas
- Nomes descritivos em kebab-case: `feature/user-authentication`
- Delete branches após merge
- Mantenha `develop` sempre funcional

### ✅ Merges

- Sempre teste antes de fazer merge
- Use Pull Requests para revisão de código
- Resolva conflitos localmente antes de fazer merge
- Mantenha histórico limpo

### ✅ Releases

- Siga versionamento semântico (SemVer): MAJOR.MINOR.PATCH
  - MAJOR: mudanças incompatíveis
  - MINOR: novas funcionalidades compatíveis
  - PATCH: correções de bugs
- Mantenha CHANGELOG atualizado
- Crie tags para cada release
- Teste completamente antes de finalizar

### ✅ Hotfixes

- Use apenas para bugs críticos em produção
- Mantenha alterações mínimas
- Teste rigorosamente
- Documente o problema e a solução

## Exemplos

Confira a pasta [exemplos/](exemplos/) para tutoriais detalhados:

- **[Feature Completa](exemplos/01-feature-completa.md)** - Workflow completo de desenvolvimento de uma feature
- **[Release](exemplos/02-release.md)** - Como preparar e lançar uma nova versão
- **[Hotfix](exemplos/03-hotfix.md)** - Corrigir bugs críticos em produção

### Exemplo Rápido: Feature

```bash
# Criar feature
git flow feature start user-login

# Desenvolver
echo "Login implementation" > login.js
git add login.js
git commit -m "feat: implementa tela de login"

# Finalizar
git flow feature finish user-login
```

## Diagrama do Fluxo

```
main      ●─────────●─────────●─────────────●─────────────●
           ↖       ↗ ↖       ↗               ↖           ↗
            release  hotfix                   release
           ↗       ↖         ↖               ↗           ↖
develop   ●─●─●─●───●─●─●─●───●─●─●─●─●─●───●─●─●─●─●─●─●
           ↖ ↗ ↖ ↗           ↖ ↗   ↖ ↗
           feature           feature
```

## Recursos Adicionais

### 📚 Documentação do Projeto

- **[Guia Rápido](GUIA-RAPIDO.md)** - Referência rápida para uso diário
- **[Melhores Práticas](MELHORES-PRATICAS.md)** - Boas práticas detalhadas
- **[Cartão de Referência](CARTAO-REFERENCIA.md)** - Comandos essenciais
- **[Exemplos Práticos](exemplos/)** - Tutoriais passo a passo
- **[Como Contribuir](CONTRIBUTING.md)** - Guia de contribuição
- **[Changelog](CHANGELOG.md)** - Histórico de mudanças

### 🔗 Links Externos

- [Post Original do GitFlow](https://nvie.com/posts/a-successful-git-branching-model/)
- [GitFlow Cheatsheet](https://danielkummer.github.io/git-flow-cheatsheet/index.pt_BR.html)
- [Conventional Commits](https://www.conventionalcommits.org/pt-br/)
- [Semantic Versioning](https://semver.org/lang/pt-BR/)

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:
- Reportar bugs
- Sugerir novas funcionalidades
- Melhorar a documentação
- Enviar Pull Requests

## Licença

Este projeto está licenciado sob a GNU General Public License v3.0 - veja o arquivo [LICENSE](LICENSE) para detalhes.

## Autor

Eduardo

---

**⭐ Se este projeto ajudou você, considere dar uma estrela!**
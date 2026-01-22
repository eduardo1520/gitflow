# Guia de Treinamento: Git Flow com Automação e GitHub CLI

Este documento serve como guia de referência para o fluxo de trabalho Git utilizado no projeto, integrando o Git Flow tradicional, Issues do GitHub e automações personalizadas para Release e Staging.

---

## 1. Pré-requisitos e Ferramentas

Para seguir este fluxo, você precisará das seguintes ferramentas:

1.  **Git**: Controle de versão.
2.  **Git Flow** (Opcional, mas recomendado): Extensão para facilitar o gerenciamento de branches.
3.  **GitHub CLI (`gh`)**: Ferramenta de linha de comando oficial do GitHub para criar Issues e Pull Requests sem sair do terminal.

### Configuração Inicial (Exemplo)
```bash
# Inicializar Git Flow no repositório
git flow init
# Aceite os padrões (Main: main, Develop: develop, Features: feature/, Releases: release/, Hotfixes: hotfix/)

# Autenticar no GitHub CLI
gh auth login
```

---

## 2. Estrutura de Branches e Ambientes

### Ambientes de Deploy
| Ambiente | Branch | Propósito | URL Exemplo |
| :--- | :--- | :--- | :--- |
| **DEV** | `develop` | Desenvolvimento e integração contínua. | `dev.seusite.com` |
| **STAGING** | `staging` | **Homologação/QA**. Testes formais e validação da release. | `staging.seusite.com` |
| **PRODUÇÃO** | `main` | Código estável para usuários finais. | `seusite.com` |

### Branches de Suporte (Temporárias)
| Tipo | Prefixo | Origem | Destino | Quando usar? |
| :--- | :--- | :--- | :--- | :--- |
| **Feature** | `feature/` | `develop` | `develop` | Novas funcionalidades. Ex: `feature/15-login` |
| **Bugfix** | `bugfix/` | `develop` | `develop` | Correção de erros em desenvolvimento. |
| **Release** | `release/` | `develop` | `main` & `develop` | Preparação de versão. Ex: `release/1.0.0` |
| **Hotfix** | `hotfix/` | `main` | `main` & `develop` | Correção urgente em produção. |

---

## 3. Fluxo de Trabalho Passo a Passo

O fluxo ideal começa com uma Issue, passa pelo desenvolvimento e termina com o Deploy.

### Cenário A: Nova Funcionalidade (Feature)

**1. Criar Issue (Planejamento)**
Antes de codar, documente o que será feito.
```bash
# Via GitHub CLI
gh issue create --title "Implementar autenticação" --body "Descrição da tarefa..." --label "enhancement"
# Anote o número da issue (ex: #15)
```

**2. Iniciar Feature**
Crie a branch vinculada à issue.
```bash
git checkout -b feature/15-implementar-autenticacao develop
# ou se usar git flow: git flow feature start 15-implementar-autenticacao
```

**3. Desenvolvimento**
Trabalhe e faça commits seguindo o padrão (ver seção de Boas Práticas).
```bash
git add .
git commit -m "feat: implementa login (#15)"
```

**4. Pull Request (Code Review)**
Envie para o remote e crie o PR para `develop`.
```bash
git push origin feature/15-implementar-autenticacao
gh pr create --title "Implementar autenticação" --body "Closes #15" --base develop
```

---

### Cenário B: Lançamento de Versão (Release) com Automação

Quando um conjunto de features está pronto na `develop`, iniciamos o ciclo de release.

**1. Iniciar Release**
```bash
git checkout -b release/1.1.0 develop
# Faça ajustes finais (bump version, changelog)
```

**2. Executar Automação de Release**
Utilize nosso comando personalizado para enviar para Staging e criar o PR.
**Comando:** `git release-push`
*   Faz o push da branch.
*   Mergeia automaticamente na branch `staging` (Deploy em QA).
*   Cria automaticamente o PR para a `main`.

**3. Aprovação e Finalização**
Após o PR ser aprovado e mergeado na `main` pelo GitHub:
**Comando:** `git release-finish`
*   Sincroniza sua `main` local.
*   Faz o back-merge para `develop`.
*   Remove a branch de release local.

---

### Cenário C: Correção Urgente (Hotfix)

**1. Iniciar Hotfix**
```bash
git checkout -b hotfix/correcao-critica main
# Corrija o bug crítico
```

**2. Executar Automação**
**Comando:** `git release-push`
*   Envia para Staging para validação rápida.
*   Cria PR para a `main`.

**3. Finalizar**
Após merge do PR:
**Comando:** `git release-finish`

---

## 4. Detalhes da Automação (Referência)

Explicando o que os scripts fazem por baixo dos panos:

### `git release-push`
1.  **Push:** `git push origin <branch>`
2.  **Staging:**
    *   `git checkout staging`
    *   `git merge <branch>`
    *   `git push origin staging`
3.  **PR:** `gh pr create --base main --head <branch> ...`

### ✅ Finalizar Processo de Release/Hotfix
**Comando:** `git release-finish`

Este comando deve ser rodado **após** o Pull Request ser aprovado e mergeado no GitHub.

**O que ele faz automaticamente:**
1.  **Sincroniza Main:** Baixa a versão mais recente da `main` (com seu merge).
2.  **Back-merge Develop:** Atualiza a `develop` com as alterações da `main` (garantindo que correções de hotfix/release voltem para o desenvolvimento).
3.  **Limpeza:** Deleta a branch de release/hotfix local para manter o ambiente limpo.

> **⚠️ Importante: Quando NÃO usar o `release-finish`?**
>
> *   **Features (`feature/*`):** Não execute este comando. Features são mergeadas diretamente na `develop` e morrem lá. O ciclo se encerra no merge do Pull Request da feature.
> *   **Releases e Hotfixes:** SIM, execute sempre para garantir que a `main` e a `develop` fiquem sincronizadas.

### 🛡️ Proteção de Branch (GitHub - Production Grade)
O hook local (`pre-commit`) ajuda, mas a segurança real de produção é configurada no GitHub.

**Como configurar (Open/Closed Principle):**
1.  Vá no seu repositório no GitHub.
2.  Clique em **Settings** > **Branches**.
3.  Clique em **Add branch protection rule**.
4.  **Branch name pattern:** `main` (e `develop` também recomendado).
5.  Marque as opções:
    *   ✅ **Require a pull request before merging:** Bloqueia pushes diretos. Ninguém entra sem PR.
    *   ✅ **Require approvals:** Exige que outra pessoa aprove seu código.
    *   ✅ **Do not allow bypassing the above settings:** Garante que nem administradores burlem a regra.

Isso garante o princípio: **Aberto para extensão (novas branches/PRs), Fechado para modificação direta.**

---

## 5. Boas Práticas e Convenções

### 📝 Padrão de Commits (Conventional Commits)
Mantenha um histórico limpo. Use prefixos:

*   `feat`: Nova funcionalidade.
*   `fix`: Correção de bug.
*   `docs`: Documentação.
*   `style`: Formatação.
*   `refactor`: Refatoração.
*   `test`: Testes.
*   `chore`: Configurações/Build.

**Exemplo:** `git commit -m "feat: adiciona botão de login (#15)"`

### 🏷️ Versionamento Semântico (SemVer)
Para branches de `release`: `vMAJOR.MINOR.PATCH`
1.  **MAJOR**: Quebra de compatibilidade.
2.  **MINOR**: Novas features compatíveis.
3.  **PATCH**: Correções de bugs.

### 📊 Visualizando o Histórico (Gráfico)
Para ver um gráfico bonito dos seus commits e branches diretamente no terminal:

**Comando:** `git log --graph --oneline --all --decorate`

**Dica:** Crie um atalho (alias) para facilitar:
```bash
git config --global alias.graph "log --graph --oneline --all --decorate"
```
Depois basta rodar: `git graph`

---

## 6. Troubleshooting (Solução de Problemas)

### Erro: "Updates were rejected because the tip of your current branch is behind"
Isso acontece se a branch remota tem alterações que você não tem.
**Solução:**
```bash
git pull origin <nome-da-branch>
```

### Erro ao deletar branch ("The branch is not fully merged")
Se o Git reclamar que a branch não foi mergeada (mas você sabe que foi via Squash ou Rebase), force a deleção:
```bash
git branch -D <nome-da-branch>
```

### Conflitos de Merge
Se houver conflitos durante o `release-push` (no merge com staging) ou `release-finish`:
1.  O Git vai pausar e mostrar os arquivos em conflito.
2.  Edite os arquivos e resolva manualmente.
3.  Adicione as correções: `git add .`
4.  Continue o processo: `git commit` ou `git merge --continue`.

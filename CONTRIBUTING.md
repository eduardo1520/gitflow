# Guia de Contribuição

Obrigado por considerar contribuir para este projeto! 🎉

## Como Contribuir

### 1. Fork e Clone

```bash
# Fork o repositório no GitHub
# Depois clone seu fork
git clone https://github.com/SEU-USUARIO/gitflow.git
cd gitflow
```

### 2. Configure o GitFlow

```bash
# Inicializar GitFlow
git flow init

# Adicionar repositório original como upstream
git remote add upstream https://github.com/eduardo1520/gitflow.git
```

### 3. Crie uma Feature

```bash
# Atualizar develop
git checkout develop
git pull upstream develop

# Criar feature branch
git flow feature start minha-contribuicao
```

### 4. Faça suas Mudanças

- Faça commits pequenos e descritivos
- Use Conventional Commits
- Teste suas mudanças

```bash
# Fazer mudanças
git add .
git commit -m "feat: adiciona nova funcionalidade"
```

### 5. Envie sua Contribuição

```bash
# Atualizar com develop
git merge develop

# Publicar feature
git flow feature publish minha-contribuicao

# Ou push direto
git push origin feature/minha-contribuicao
```

### 6. Abra um Pull Request

- Vá para o GitHub
- Clique em "New Pull Request"
- Base branch: `develop`
- Compare branch: `feature/minha-contribuicao`
- Descreva suas mudanças
- Aguarde review

## Tipos de Contribuições

### 📖 Documentação

Melhorias na documentação são sempre bem-vindas:

- Corrigir erros de digitação
- Adicionar exemplos
- Melhorar explicações
- Traduzir para outros idiomas

### 🐛 Reportar Bugs

Ao reportar bugs, inclua:

- Descrição clara do problema
- Passos para reproduzir
- Comportamento esperado vs atual
- Versão do Git e Git Flow
- Sistema operacional

### 💡 Sugerir Funcionalidades

Ao sugerir funcionalidades:

- Descreva o problema que resolve
- Explique a solução proposta
- Considere alternativas
- Indique se pode implementar

### 🛠️ Melhorias no Script

Melhorias no `gitflow-helper.sh`:

- Novas funcionalidades
- Correção de bugs
- Melhoria de UX
- Otimizações

## Padrões de Código

### Commits

Use Conventional Commits:

```bash
feat: adiciona nova funcionalidade
fix: corrige bug
docs: atualiza documentação
style: formatação
refactor: refatoração
test: testes
chore: manutenção
```

### Markdown

- Use títulos hierárquicos (`#`, `##`, `###`)
- Adicione emojis quando apropriado
- Mantenha linhas com máximo 80 caracteres
- Use blocos de código com syntax highlighting

### Bash Scripts

- Use `#!/bin/bash` no início
- Adicione comentários explicativos
- Use nomes de variáveis descritivos
- Valide entrada do usuário
- Trate erros apropriadamente

## Checklist do Pull Request

Antes de enviar um PR, verifique:

- [ ] Código funciona conforme esperado
- [ ] Testes passam (se aplicável)
- [ ] Documentação atualizada
- [ ] Commits seguem Conventional Commits
- [ ] Branch atualizada com `develop`
- [ ] Sem conflitos
- [ ] Descrição clara do PR

## Code Review

### Como Autor

- Seja receptivo ao feedback
- Responda comentários prontamente
- Faça mudanças solicitadas
- Agradeça os revisores

### Como Revisor

- Seja construtivo
- Explique sugestões
- Elogie bom código
- Seja específico

## Processo de Review

1. Mantenedor revisa o PR
2. Pode solicitar mudanças
3. Você faz as mudanças
4. Mantenedor aprova
5. PR é mergeado

## Dúvidas?

- Abra uma [Issue](https://github.com/eduardo1520/gitflow/issues)
- Entre em contato com os mantenedores

## Código de Conduta

### Nossos Padrões

- Seja respeitoso
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Mostre empatia

### Comportamentos Inaceitáveis

- Uso de linguagem ofensiva
- Ataques pessoais
- Assédio público ou privado
- Publicar informações privadas

## Licença

Ao contribuir, você concorda que suas contribuições serão licenciadas sob a GNU General Public License v3.0.

---

**Obrigado por contribuir! 🚀**

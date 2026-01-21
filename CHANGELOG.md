# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Versionamento Semântico](https://semver.org/lang/pt-BR/spec/v2.0.0.html).

## [Não Lançado]

### Adicionado
- README.md completo com documentação em português
  - Explicação detalhada do GitFlow
  - Instruções de instalação e configuração
  - Descrição de branches principais e tipos
  - Fluxo de trabalho passo a passo
  - Comandos úteis e atalhos
  - Diagramas visuais do fluxo
  - Links para recursos externos
  
- Scripts auxiliares interativos
  - `gitflow-helper.sh` - Menu completo usando git-flow
  - `gitflow-manual.sh` - Versão usando apenas Git nativo
  - Interface colorida e amigável
  - Funções para gerenciar features, releases e hotfixes
  
- Guias complementares
  - `GUIA-RAPIDO.md` - Referência rápida para uso diário
  - `MELHORES-PRATICAS.md` - Boas práticas detalhadas
  - `CARTAO-REFERENCIA.md` - Cartão de referência de comandos
  - `CONTRIBUTING.md` - Guia de contribuição
  
- Exemplos práticos na pasta `exemplos/`
  - Exemplo de feature completa com código
  - Exemplo de release com versionamento
  - Exemplo de hotfix para bugs críticos
  - README explicativo dos exemplos

### Características Principais

#### 📚 Documentação Completa
- Mais de 1500 linhas de documentação em português
- Cobertura completa do workflow GitFlow
- Exemplos práticos e didáticos
- Organização clara por tópicos

#### 🛠️ Scripts Auxiliares
- Menu interativo para facilitar operações
- Duas versões: com e sem git-flow
- Verificações de segurança
- Mensagens coloridas e informativas

#### 📖 Guias de Referência
- Guia rápido para consulta diária
- Melhores práticas de commits, branches e releases
- Cartão de referência com comandos essenciais
- Troubleshooting de problemas comuns

#### 💡 Exemplos Práticos
- Tutoriais passo a passo
- Código de exemplo
- Outputs esperados
- Dicas e armadilhas comuns

## [0.1.0] - YYYY-MM-DD (Exemplo Futuro)

### Adicionado
- Nova funcionalidade X
- Suporte para Y

### Modificado
- Melhorada performance de Z
- Atualizada documentação

### Corrigido
- Bug em W
- Problema de compatibilidade

### Removido
- Funcionalidade obsoleta

## Como Usar Este Changelog

### Tipos de Mudanças

- `Adicionado` - para novas funcionalidades
- `Modificado` - para mudanças em funcionalidades existentes
- `Descontinuado` - para funcionalidades que serão removidas
- `Removido` - para funcionalidades removidas
- `Corrigido` - para correções de bugs
- `Segurança` - para patches de vulnerabilidades

### Versionamento Semântico

Dado um número de versão MAJOR.MINOR.PATCH, incremente:

1. MAJOR quando fizer mudanças incompatíveis na API
2. MINOR quando adicionar funcionalidades mantendo compatibilidade
3. PATCH quando corrigir bugs mantendo compatibilidade

Exemplo:
- 1.0.0 → 1.0.1 (correção de bug)
- 1.0.1 → 1.1.0 (nova funcionalidade)
- 1.1.0 → 2.0.0 (mudança incompatível)

---

[Não Lançado]: https://github.com/eduardo1520/gitflow/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/eduardo1520/gitflow/releases/tag/v0.1.0

# Exemplos GitFlow

Esta pasta contém exemplos práticos de uso do GitFlow.

## Exemplos Disponíveis

### 1. [Feature Completa](01-feature-completa.md)
Demonstra o fluxo completo de desenvolvimento de uma nova funcionalidade:
- Criar feature branch
- Desenvolver e commitar
- Finalizar e integrar em develop

### 2. [Release](02-release.md)
Mostra como preparar e lançar uma nova versão:
- Criar release branch
- Atualizar versão e changelog
- Finalizar e enviar para produção

### 3. [Hotfix](03-hotfix.md)
Explica como corrigir bugs críticos em produção:
- Criar hotfix branch
- Corrigir problema urgente
- Aplicar correção em main e develop

## Como Usar os Exemplos

Cada exemplo contém:
- **Cenário:** Situação que você enfrentará
- **Passo a Passo:** Comandos detalhados
- **Comandos Resumidos:** Versão rápida para referência
- **Dicas:** Boas práticas e avisos

## Testando Localmente

Você pode seguir os exemplos em um repositório de teste:

```bash
# Criar repositório de teste
mkdir gitflow-test
cd gitflow-test
git init

# Criar commit inicial
echo "# Teste" > README.md
git add README.md
git commit -m "Initial commit"

# Criar branch develop
git checkout -b develop

# Inicializar GitFlow
git flow init

# Agora siga um dos exemplos!
```

## Fluxo Visual

```
       main    ●────────────●─────────────●
                ↖          ↗ ↖           ↗
                 release      hotfix
                ↗          ↖             ↖
    develop    ●─●─●─●─────●─●─●─●─●─●───●
                ↖ ↗ ↖ ↗     
                features    
```

## Recursos

Voltar para:
- [README Principal](../README.md)
- [Guia Rápido](../GUIA-RAPIDO.md)
- [Melhores Práticas](../MELHORES-PRATICAS.md)

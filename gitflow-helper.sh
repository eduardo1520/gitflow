#!/bin/bash

# GitFlow Helper Script
# Este script auxilia no uso do GitFlow com um menu interativo

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir cabeçalho
show_header() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     GitFlow Helper - Menu Principal    ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo ""
}

# Função para verificar se git flow está instalado
check_gitflow() {
    if ! command -v git-flow &> /dev/null; then
        echo -e "${RED}Erro: Git Flow não está instalado!${NC}"
        echo ""
        echo "Instale usando:"
        echo "  Ubuntu/Debian: sudo apt-get install git-flow"
        echo "  macOS: brew install git-flow-avh"
        echo "  Windows: Baixe de https://github.com/petervanderdoes/gitflow-avh"
        exit 1
    fi
}

# Função para verificar se estamos em um repositório git
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}Erro: Não estamos em um repositório Git!${NC}"
        exit 1
    fi
}

# Função para inicializar git flow
init_gitflow() {
    echo -e "${YELLOW}Inicializando GitFlow...${NC}"
    echo ""
    
    if git config --get gitflow.branch.master &> /dev/null; then
        echo -e "${GREEN}GitFlow já está inicializado!${NC}"
    else
        echo "Pressione ENTER para aceitar os valores padrão"
        git flow init
        echo -e "${GREEN}GitFlow inicializado com sucesso!${NC}"
    fi
    
    read -p "Pressione ENTER para continuar..."
}

# Menu de Features
feature_menu() {
    while true; do
        show_header
        echo -e "${GREEN}=== Gerenciar Features ===${NC}"
        echo ""
        echo "1) Criar nova feature"
        echo "2) Listar features"
        echo "3) Publicar feature"
        echo "4) Finalizar feature"
        echo "5) Deletar feature"
        echo "0) Voltar"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                echo ""
                read -p "Nome da feature: " feature_name
                if [ -n "$feature_name" ]; then
                    git flow feature start "$feature_name"
                    echo -e "${GREEN}Feature '$feature_name' criada!${NC}"
                else
                    echo -e "${RED}Nome inválido!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            2)
                echo ""
                git flow feature list
                read -p "Pressione ENTER para continuar..."
                ;;
            3)
                echo ""
                read -p "Nome da feature para publicar: " feature_name
                if [ -n "$feature_name" ]; then
                    git flow feature publish "$feature_name"
                    echo -e "${GREEN}Feature '$feature_name' publicada!${NC}"
                else
                    echo -e "${RED}Nome inválido!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            4)
                echo ""
                read -p "Nome da feature para finalizar: " feature_name
                if [ -n "$feature_name" ]; then
                    git flow feature finish "$feature_name"
                    echo -e "${GREEN}Feature '$feature_name' finalizada!${NC}"
                else
                    echo -e "${RED}Nome inválido!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            5)
                echo ""
                read -p "Nome da feature para deletar: " feature_name
                if [ -n "$feature_name" ]; then
                    git branch -D "feature/$feature_name"
                    echo -e "${GREEN}Feature '$feature_name' deletada!${NC}"
                else
                    echo -e "${RED}Nome inválido!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}Opção inválida!${NC}"
                read -p "Pressione ENTER para continuar..."
                ;;
        esac
    done
}

# Menu de Releases
release_menu() {
    while true; do
        show_header
        echo -e "${GREEN}=== Gerenciar Releases ===${NC}"
        echo ""
        echo "1) Criar nova release"
        echo "2) Listar releases"
        echo "3) Publicar release"
        echo "4) Finalizar release"
        echo "0) Voltar"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                echo ""
                read -p "Versão da release (ex: 1.0.0): " version
                if [ -n "$version" ]; then
                    git flow release start "$version"
                    echo -e "${GREEN}Release '$version' criada!${NC}"
                else
                    echo -e "${RED}Versão inválida!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            2)
                echo ""
                git flow release list
                read -p "Pressione ENTER para continuar..."
                ;;
            3)
                echo ""
                read -p "Versão da release para publicar: " version
                if [ -n "$version" ]; then
                    git flow release publish "$version"
                    echo -e "${GREEN}Release '$version' publicada!${NC}"
                else
                    echo -e "${RED}Versão inválida!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            4)
                echo ""
                read -p "Versão da release para finalizar: " version
                if [ -n "$version" ]; then
                    git flow release finish "$version" -m "Release $version"
                    echo -e "${GREEN}Release '$version' finalizada!${NC}"
                    echo ""
                    echo -e "${YELLOW}Não esqueça de fazer push:${NC}"
                    echo "  git push origin develop"
                    echo "  git push origin main"
                    echo "  git push origin --tags"
                else
                    echo -e "${RED}Versão inválida!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}Opção inválida!${NC}"
                read -p "Pressione ENTER para continuar..."
                ;;
        esac
    done
}

# Menu de Hotfixes
hotfix_menu() {
    while true; do
        show_header
        echo -e "${GREEN}=== Gerenciar Hotfixes ===${NC}"
        echo ""
        echo "1) Criar novo hotfix"
        echo "2) Listar hotfixes"
        echo "3) Finalizar hotfix"
        echo "0) Voltar"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                echo ""
                read -p "Versão do hotfix (ex: 1.0.1): " version
                if [ -n "$version" ]; then
                    git flow hotfix start "$version"
                    echo -e "${GREEN}Hotfix '$version' criado!${NC}"
                else
                    echo -e "${RED}Versão inválida!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            2)
                echo ""
                git flow hotfix list
                read -p "Pressione ENTER para continuar..."
                ;;
            3)
                echo ""
                read -p "Versão do hotfix para finalizar: " version
                if [ -n "$version" ]; then
                    git flow hotfix finish "$version" -m "Hotfix $version"
                    echo -e "${GREEN}Hotfix '$version' finalizado!${NC}"
                    echo ""
                    echo -e "${YELLOW}Não esqueça de fazer push:${NC}"
                    echo "  git push origin develop"
                    echo "  git push origin main"
                    echo "  git push origin --tags"
                else
                    echo -e "${RED}Versão inválida!${NC}"
                fi
                read -p "Pressione ENTER para continuar..."
                ;;
            0)
                break
                ;;
            *)
                echo -e "${RED}Opção inválida!${NC}"
                read -p "Pressione ENTER para continuar..."
                ;;
        esac
    done
}

# Visualizar status
show_status() {
    show_header
    echo -e "${GREEN}=== Status do Repositório ===${NC}"
    echo ""
    
    echo -e "${YELLOW}Branch atual:${NC}"
    git branch --show-current
    echo ""
    
    echo -e "${YELLOW}Todas as branches:${NC}"
    git branch -a
    echo ""
    
    echo -e "${YELLOW}Últimos commits:${NC}"
    git log --oneline --graph --decorate -10
    echo ""
    
    echo -e "${YELLOW}Status:${NC}"
    git status
    echo ""
    
    read -p "Pressione ENTER para continuar..."
}

# Sincronizar branches
sync_branches() {
    show_header
    echo -e "${GREEN}=== Sincronizar Branches ===${NC}"
    echo ""
    
    echo -e "${YELLOW}Sincronizando com o repositório remoto...${NC}"
    git fetch --all --prune
    echo ""
    
    echo -e "${GREEN}Sincronização concluída!${NC}"
    echo ""
    
    read -p "Deseja atualizar a branch develop? (s/n): " update_develop
    if [ "$update_develop" = "s" ] || [ "$update_develop" = "S" ]; then
        git checkout develop
        git pull origin develop
        echo -e "${GREEN}Branch develop atualizada!${NC}"
    fi
    echo ""
    
    read -p "Pressione ENTER para continuar..."
}

# Menu principal
main_menu() {
    check_gitflow
    check_git_repo
    
    while true; do
        show_header
        echo "1) Inicializar GitFlow"
        echo "2) Gerenciar Features"
        echo "3) Gerenciar Releases"
        echo "4) Gerenciar Hotfixes"
        echo "5) Visualizar Status"
        echo "6) Sincronizar Branches"
        echo "7) Ajuda Rápida"
        echo "0) Sair"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                init_gitflow
                ;;
            2)
                feature_menu
                ;;
            3)
                release_menu
                ;;
            4)
                hotfix_menu
                ;;
            5)
                show_status
                ;;
            6)
                sync_branches
                ;;
            7)
                show_header
                echo -e "${GREEN}=== Ajuda Rápida ===${NC}"
                echo ""
                echo -e "${YELLOW}Fluxo básico:${NC}"
                echo "1. Crie features para novas funcionalidades"
                echo "2. Finalize features para integrar em develop"
                echo "3. Crie releases quando estiver pronto para produção"
                echo "4. Finalize releases para enviar para main"
                echo "5. Use hotfixes apenas para correções urgentes em produção"
                echo ""
                echo -e "${YELLOW}Branches principais:${NC}"
                echo "- main/master: código de produção"
                echo "- develop: código em desenvolvimento"
                echo ""
                echo -e "${YELLOW}Tipos de branches:${NC}"
                echo "- feature/*: novas funcionalidades"
                echo "- release/*: preparação para release"
                echo "- hotfix/*: correções urgentes"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            0)
                echo ""
                echo -e "${GREEN}Até logo!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opção inválida!${NC}"
                read -p "Pressione ENTER para continuar..."
                ;;
        esac
    done
}

# Executar menu principal
main_menu

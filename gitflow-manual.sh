#!/bin/bash

# GitFlow Manual Helper Script
# Este script auxilia no uso do GitFlow usando comandos Git nativos
# Não requer git-flow instalado

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
    echo -e "${BLUE}║  GitFlow Manual Helper - Comandos Git  ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo ""
}

# Função para verificar se estamos em um repositório git
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}Erro: Não estamos em um repositório Git!${NC}"
        exit 1
    fi
}

# Criar feature
create_feature() {
    echo -e "${YELLOW}Criar Feature${NC}"
    echo ""
    read -p "Nome da feature: " feature_name
    if [ -z "$feature_name" ]; then
        echo -e "${RED}Nome inválido!${NC}"
        return
    fi
    
    echo -e "${YELLOW}Criando feature/$feature_name...${NC}"
    git checkout develop
    git checkout -b "feature/$feature_name"
    echo -e "${GREEN}Feature criada! Você está em feature/$feature_name${NC}"
}

# Finalizar feature
finish_feature() {
    echo -e "${YELLOW}Finalizar Feature${NC}"
    echo ""
    
    current_branch=$(git branch --show-current)
    if [[ ! $current_branch == feature/* ]]; then
        echo -e "${RED}Você não está em uma feature branch!${NC}"
        return
    fi
    
    feature_name=${current_branch#feature/}
    echo "Finalizando feature: $feature_name"
    
    # Merge em develop
    git checkout develop
    git merge --no-ff "$current_branch" -m "Merge feature/$feature_name into develop"
    
    # Deletar branch
    git branch -d "$current_branch"
    
    echo -e "${GREEN}Feature finalizada e mesclada em develop!${NC}"
}

# Criar release
create_release() {
    echo -e "${YELLOW}Criar Release${NC}"
    echo ""
    read -p "Versão da release (ex: 1.0.0): " version
    if [ -z "$version" ]; then
        echo -e "${RED}Versão inválida!${NC}"
        return
    fi
    
    echo -e "${YELLOW}Criando release/$version...${NC}"
    git checkout develop
    git checkout -b "release/$version"
    echo -e "${GREEN}Release criada! Você está em release/$version${NC}"
}

# Finalizar release
finish_release() {
    echo -e "${YELLOW}Finalizar Release${NC}"
    echo ""
    
    current_branch=$(git branch --show-current)
    if [[ ! $current_branch == release/* ]]; then
        echo -e "${RED}Você não está em uma release branch!${NC}"
        return
    fi
    
    version=${current_branch#release/}
    echo "Finalizando release: $version"
    
    # Merge em main
    git checkout main 2>/dev/null || git checkout master
    git merge --no-ff "$current_branch" -m "Release $version"
    git tag -a "v$version" -m "Release $version"
    
    # Merge em develop
    git checkout develop
    git merge --no-ff "$current_branch" -m "Merge release $version into develop"
    
    # Deletar branch
    git branch -d "$current_branch"
    
    echo -e "${GREEN}Release finalizada!${NC}"
    echo -e "${YELLOW}Lembre-se de fazer push:${NC}"
    echo "  git push origin develop"
    echo "  git push origin main"
    echo "  git push origin --tags"
}

# Criar hotfix
create_hotfix() {
    echo -e "${YELLOW}Criar Hotfix${NC}"
    echo ""
    read -p "Versão do hotfix (ex: 1.0.1): " version
    if [ -z "$version" ]; then
        echo -e "${RED}Versão inválida!${NC}"
        return
    fi
    
    echo -e "${YELLOW}Criando hotfix/$version...${NC}"
    git checkout main 2>/dev/null || git checkout master
    git checkout -b "hotfix/$version"
    echo -e "${GREEN}Hotfix criado! Você está em hotfix/$version${NC}"
}

# Finalizar hotfix
finish_hotfix() {
    echo -e "${YELLOW}Finalizar Hotfix${NC}"
    echo ""
    
    current_branch=$(git branch --show-current)
    if [[ ! $current_branch == hotfix/* ]]; then
        echo -e "${RED}Você não está em uma hotfix branch!${NC}"
        return
    fi
    
    version=${current_branch#hotfix/}
    echo "Finalizando hotfix: $version"
    
    # Merge em main
    git checkout main 2>/dev/null || git checkout master
    git merge --no-ff "$current_branch" -m "Hotfix $version"
    git tag -a "v$version" -m "Hotfix $version"
    
    # Merge em develop
    git checkout develop
    git merge --no-ff "$current_branch" -m "Merge hotfix $version into develop"
    
    # Deletar branch
    git branch -d "$current_branch"
    
    echo -e "${GREEN}Hotfix finalizado!${NC}"
    echo -e "${YELLOW}Lembre-se de fazer push:${NC}"
    echo "  git push origin develop"
    echo "  git push origin main"
    echo "  git push origin --tags"
}

# Listar branches
list_branches() {
    echo -e "${YELLOW}Features:${NC}"
    git branch | grep "feature/" || echo "  Nenhuma feature"
    echo ""
    echo -e "${YELLOW}Releases:${NC}"
    git branch | grep "release/" || echo "  Nenhuma release"
    echo ""
    echo -e "${YELLOW}Hotfixes:${NC}"
    git branch | grep "hotfix/" || echo "  Nenhum hotfix"
}

# Status
show_status() {
    show_header
    echo -e "${GREEN}=== Status do Repositório ===${NC}"
    echo ""
    echo -e "${YELLOW}Branch atual:${NC}"
    git branch --show-current
    echo ""
    list_branches
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Menu principal
main_menu() {
    check_git_repo
    
    while true; do
        show_header
        echo "Features:"
        echo "  1) Criar feature"
        echo "  2) Finalizar feature"
        echo ""
        echo "Releases:"
        echo "  3) Criar release"
        echo "  4) Finalizar release"
        echo ""
        echo "Hotfixes:"
        echo "  5) Criar hotfix"
        echo "  6) Finalizar hotfix"
        echo ""
        echo "Outros:"
        echo "  7) Ver status"
        echo "  8) Ajuda"
        echo "  0) Sair"
        echo ""
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1) create_feature; read -p "Pressione ENTER..." ;;
            2) finish_feature; read -p "Pressione ENTER..." ;;
            3) create_release; read -p "Pressione ENTER..." ;;
            4) finish_release; read -p "Pressione ENTER..." ;;
            5) create_hotfix; read -p "Pressione ENTER..." ;;
            6) finish_hotfix; read -p "Pressione ENTER..." ;;
            7) show_status ;;
            8)
                show_header
                echo -e "${GREEN}=== Comandos Git Equivalentes ===${NC}"
                echo ""
                echo "Feature:"
                echo "  Criar:     git checkout develop && git checkout -b feature/nome"
                echo "  Finalizar: git checkout develop && git merge --no-ff feature/nome"
                echo ""
                echo "Release:"
                echo "  Criar:     git checkout develop && git checkout -b release/1.0.0"
                echo "  Finalizar: git checkout main && git merge --no-ff release/1.0.0"
                echo "             git tag -a v1.0.0 -m 'Release 1.0.0'"
                echo "             git checkout develop && git merge --no-ff release/1.0.0"
                echo ""
                echo "Hotfix:"
                echo "  Criar:     git checkout main && git checkout -b hotfix/1.0.1"
                echo "  Finalizar: git checkout main && git merge --no-ff hotfix/1.0.1"
                echo "             git tag -a v1.0.1 -m 'Hotfix 1.0.1'"
                echo "             git checkout develop && git merge --no-ff hotfix/1.0.1"
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
                read -p "Pressione ENTER..."
                ;;
        esac
    done
}

# Executar menu principal
main_menu

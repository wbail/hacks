#!/bin/bash

echo "Initial setup"
echo "Will install and configure:"
echo "> wget"
echo "> git"
echo "> vim"
echo "> dotnet"
echo "> curl"
echo "> dotnet_create_project.sh (made by @wbail)"

update() {
    apt-get update
}

upgrade() {
    apt-get upgrade
}

install_git() {
    update
    apt-get install -y git
}

install_wget() {
    update
    apt-get install -y wget
}

install_dotnet_project_template() {
    wget https://github.com/wbail/hacks/dotnet_create_project.sh -O /mnt/c/Users/gbail/source/repos/dotnet_create_project.sh
}

install_dotnet() {
    
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    update

    apt-get install -y dotnet-sdk-6.0
}

install_vim() {
    update
    apt-get install -y vim
}

install_curl() {
    update
    apt-get install -y curl
}

config_git() {
    git config --global user.name "Guilherme Bail"
    git config --global user.email "guilhermedanbail@gmail.com"
    git config --global init.defaultBranch main
}

create_alias_for_projects_folder() {
    echo 'alias p="cd /mnt/c/Users/gbail/source/repos/"' >> ~/.bashrc
    source ~/.bashrc
}

main() {
    update
    upgrade
    install_wget
    install_git
    config_git
    install_dotnet
    install_vim
    install_curl
    install_dotnet_project_template
    create_alias_for_projects_folder
}

main


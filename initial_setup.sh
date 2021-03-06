#!/bin/bash

echo "Initial setup"
echo "Will install and configure:"
echo "> wget"
echo "> git"
echo "> vim"
echo "> dotnet"
echo "> curl"
echo "> gcc"
echo "> cmake"
echo "> rsync"
echo "> zip"
echo "> dotnet_create_project.sh (made by @wbail)"
echo "> dotnet ef"
echo "> azure cli"
echo "> azure func cli"

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

backup_vimrc() {
	sudo cp /etc/vim/vimrc /etc/vim/vimrc_backup
}

configure_vim_settings() {
<<comment	
"
syntax on
set number
set tabstop=4
set shiftwidth=4
set background=dark
"
comment
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

backup_bashrc() {
    cp ~/.bashrc ~/.bashrc_backup
}

add_git_branch_on_terminal() {
    
    backup_bashrc

    <<comment
"
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi

# THE SIX LINES BELOW are the default prompt and the unset (which were in the original .bashrc)
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt"
comment

}

install_gcc() {
    update
    sudo apt install -y g++
}

install_cmake() {
    update
    sudo apt install -y gdb make ninja-build
}

install_rsync() {
    update
    sudo apt install -y rsync
}

install_zip() {
    update
    sudo apt install -y zip
}

create_alias_for_projects_folder() {
    backup_bashrc
    echo 'alias p="cd /mnt/c/Users/gbail/source/repos/"' >> ~/.bashrc
    source ~/.bashrc
}

install_dotnet_ef_core() {
    dotnet tool install --global dotnet-ef
}

install_azure_cli() {
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}

install_azure_func_cli() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
    update
    sudo apt-get install -y azure-functions-core-tools-4
}

main() {
    update
    upgrade
    install_wget
    install_git
    config_git
    install_dotnet
    install_dotnet_ef_core
    install_vim
    install_curl
    install_gcc
    install_cmake
    install_rsync
    install_zip
    install_azure_cli
    install_azure_func_cli
    install_dotnet_project_template
    create_alias_for_projects_folder
}

main


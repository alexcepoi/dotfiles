#!/bin/bash

function install_bashrc {
    echo '> Installing .bashrc'
    cp root_bashrc "$HOME/.bashrc"
    cp root_profile "$HOME/.profile"
}

function install_dotvim {
    echo '> Installing .vim'
    git clone https://github.com/alexcepoi/dotvim.git "$HOME/.vim"
    vim +PlugInstall +qall
}

# main
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi
[ -f "$HOME/.bashrc" ] && echo "> Skipping bashrc" || install_bashrc
[ -d "$HOME/.vim" ] && echo "> Skipping vim" || install_dotvim

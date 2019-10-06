#!/bin/bash

function install_dotvim {
    echo '> Installing .vim'
    git clone git@github.com:alexcepoi/dotvim.git "$HOME/.vim"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
}

function install_dotfiles {
    echo '> Installing dotfiles'
    stow -t $HOME -d $(dirname "$0")/.. common debian
}

# main
[ -d "$HOME/.vim" ] && echo "> Skipping vim" || install_dotvim
install_dotfiles

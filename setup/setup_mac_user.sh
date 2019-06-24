#!/bin/bash

HOMEBREW_PREFIX="$HOME/brew"
HOMEBREW_BIN="$HOMEBREW_PREFIX/bin/brew"

function install_homebrew {
    echo '> Installing hombrew'
    git clone https://github.com/Homebrew/brew.git $HOMEBREW_PREFIX

    echo '> Installing packages'
    $HOMEBREW_BIN tap thoughtbot/formulae
    $HOMEBREW_BIN install `tr '\n' ' ' < pkg_brew`
}

function install_dotvim {
    echo '> Installing .vim'
    git clone https://github.com/alexcepoi/dotvim.git "$HOME/.vim"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
}

function install_dotfiles {
    echo '> Installing dotfiles'
    cp rcrc "$HOME/.rcrc"
    PATH=$HOMEBREW_BIN:$PATH rcup
}

# main
command -v brew &> /dev/null && echo "> Skipping homebrew" || install_homebrew
[ -d "$HOME/.vim" ] && echo "> Skipping vim" || install_dotvim
[ -f "$HOME/.rcrc" ] && echo "> Skipping dotfiles" || install_dotfiles

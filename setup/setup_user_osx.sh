#!/bin/bash

HOMEBREW_PREFIX="$HOME/brew"
HOMEBREW_BIN="$HOMEBREW_PREFIX/bin/brew"

function install_homebrew {
  if command -v brew &> /dev/null; then
    echo "> Skipping homebrew" || install_homebrew
  else
    echo '> Installing hombrew'
    git clone https://github.com/Homebrew/brew.git $HOMEBREW_PREFIX

    echo '> Installing packages'
    $HOMEBREW_BIN install `tr '\n' ' ' < ${BASH_SOURCE%/*}/pkg_brew`
  fi
}

function install_dotvim {
  if [ -d "$HOME/.vim" ]; then
    echo "> Skipping vim"
  else
    echo '> Installing .vim'
    git clone git@github.com:alexcepoi/dotvim.git "$HOME/.vim"
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          vim +PlugInstall +qall
  fi
}

function install_dotfiles {
  echo '> Installing dotfiles'
  PATH=$HOMEBREW_BIN:$PATH stow -t $HOME -d ${BASH_SOURCE%/*}/.. common osx -v
}

# main
install_homebrew
install_dotvim
install_dotfiles

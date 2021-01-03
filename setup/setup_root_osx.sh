#!/bin/bash

function install_bashrc {
  if [ -f "$HOME/.bashrc" ]; then
    echo "> Skipping bashrc"
  else
    echo '> Installing .bashrc'
    cp ${BASH_SOURCE%/*}/root_bashrc_osx "$HOME/.bashrc"
    cp ${BASH_SOURCE%/*}/root_profile_osx "$HOME/.profile"
  fi
}

function install_dotvim {
  if [ -d "$HOME/.vim" ]; then
    echo "> Skipping vim"
  else
    echo '> Installing .vim'
    git clone https://github.com/alexcepoi/dotvim.git "$HOME/.vim"
    vim +PlugInstall +qall
  fi
}

# main
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

install_bashrc
install_dotvim

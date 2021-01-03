#!/bin/bash

function setup_debian {
  echo '> Installing dotfiles'
  stow -t $HOME -d ${BASH_SOURCE%/*}/.. common debian -v
}

function setup_gentoo {
  echo '> Installing dotfiles'
  stow -t $HOME -d ${BASH_SOURCE%/*}/.. common -v
}

function setup_shared {
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

# main
case $(grep ID /etc/os-release) in
  *debian*)
    setup_debian ;;
  *gentoo*)
    setup_gentoo ;;
  *)
    echo "Linux distribution is not supported."
    exit 1;;
esac
setup_shared

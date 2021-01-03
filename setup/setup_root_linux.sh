#!/bin/bash

function setup_debian {
  cp -nvT ${BASH_SOURCE%/*}/apt_conf /etc/apt/apt.conf.d/00custom
  aptitude markauto '(~i !~M) (~slibs|~soldlibs|~spython|~sperl) !(~E|~prequired|~pimportant)'
  apt install `tr '\n' ' ' < ${BASH_SOURCE%/*}pkg_debian`
  apt purge nano joe screen most iptables
  apt autoremove --purge

  timedatectl set-ntp true
  cp -vT ${BASH_SOURCE%/*}/nftables.conf /etc/nftables.conf && \
    systemctl enable nftables && \
    systemctl start nftables
}

function setup_gentoo {
  sort -u /var/lib/portage/world ${BASH_SOURCE%/*}/pkg_gentoo > /var/lib/portage/world
  emerge -NuDav world
}

function setup_shared {
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

#!/bin/bash

function install_packages {
  cp -nvT apt_conf /etc/apt/apt.conf.d/00custom
  aptitude markauto '(~i !~M) (~slibs|~soldlibs|~spython|~sperl) !(~E|~prequired|~pimportant)'
  apt install `tr '\n' ' ' < pkg_debian`
  apt purge nano joe screen most iptables
  apt autoremove --purge
}

function setup_system {
  timedatectl set-ntp true
  cp -vT nftables.conf /etc/nftables.conf && systemctl enable nftables && systemctl start nftables
}

function install_dotvim {
  echo '> Installing .vim'
  git clone https://github.com/alexcepoi/dotvim.git "$HOME/.vim"
  vim +PlugInstall +qall
}

# main
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

install_packages
setup_system
[ -d "$HOME/.vim" ] && echo "> Skipping vim" || install_dotvim

#!/bin/bash

function install_homebrew {
    echo 'Installing hombrew'
    sudo git clone https://github.com/Homebrew/brew.git /usr/local/homebrew
    sudo chown -R $(whoami):admin /usr/local/homebrew
}

function install_bashrc {
    echo 'Installing .bashrc'
    sudo cp DIR_COLORS /etc/DIR_COLORS
    sudo cp bashrc.local /etc/bashrc.local

    sudo -H -s cp bashrc '$HOME/.bashrc'
    sudo -H -s cp profile '$HOME/.profile'

    cp bashrc ~/.bashrc && source ~/.bashrc
    cp profile ~/.profile && source ~/.profile
}

function install_packages {
    echo 'Installing packages'
    brew install vim --with-override-system-vi
    brew tap thoughtbot/formulae
    brew install `tr '\n' ' ' < pkg_brew`
}

function install_dotvim {
    echo 'Installing .vim'
    sudo git clone https://github.com/alexcepoi/dotvim.git /etc/vim
    sudo git clone https://github.com/gmarik/Vundle.vim.git /etc/vim/bundle/Vundle.vim
    sudo vim +PluginInstall +qall

    cp vimrc ~/.vimrc
    sudo -H -s cp vimrc '$HOME/.vimrc'
}

function install_dotfiles {
    echo 'Installing dotfiles'
    cp rcrc ~/.rcrc
    rcup -t mac
}

# main
command -v brew &> /dev/null || install_homebrew
install_bashrc
install_packages
[ -d /etc/vim ] || install_dotvim
install_dotfiles

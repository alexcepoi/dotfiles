#!/bin/bash
function install_homebrew {
    trap "{ rm -f brew.rb; }" EXIT
    curl -L "https://raw.githubusercontent.com/Homebrew/install/master/install" > brew.rb
    sed -i "" "s;HOMEBREW_PREFIX = .*;HOMEBREW_PREFIX = '/usr/homebrew';" brew.rb
    ruby brew.rb
}

function install_bashrc {
    sudo cp DIR_COLORS /etc/DIR_COLORS
    sudo cp bashrc.local /etc/bashrc.local

    sudo -H -s "cp bashrc ~/.bashrc"
    sudo -H -s "cp profile ~/.profile"

    cp bashrc ~/.bashrc && source ~/.bashrc
    cp profile ~/.profile && source ~/.profile
}

function install_packages {
    brew tap thoughtbot/formulae
    brew install `tr '\n' ' ' < pkg_brew`
}

function install_dotvim {
    sudo git clone https://github.com/alexcepoi/dotvim.git /etc/vim
    sudo git clone https://github.com/gmarik/Vundle.vim.git /etc/vim/bundle/Vundle.vim
    sudo vim +PluginInstall +qall

    cp vimrc ~/.vimrc
    sudo -H -s "cp vimrc ~/.vimrc"
}

function install_dotfiles {
    cp rcrc ~/.rcrc
    rcup -t mac

    # setup mpd
    mkdir -p ~/.config/mpd
    ln -sfv /usr/homebrew/opt/mpd/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mpd.plist
}

# main
command -v brew &> /dev/null || install_homebrew
install_bashrc
install_packages
[ -d /etc/vim ] || install_dotvim
install_dotfiles

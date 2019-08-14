#! /usr/bin/env bash

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] \[\e]0;\a\007\]'

# Load any common interactive shell settings if present.
[ -r ~/.shrc ]  && source ~/.shrc

# Environment variables
export HISTSIZE=100000

# Bash options
shopt -s globstar
[ -r $BREW_PREFIX/etc/bash_completion ] && source $BREW_PREFIX/etc/bash_completion
[ -r $BREW_PREFIX/etc/grc.bashrc ] && source "$BREW_PREFIX/etc/grc.bashrc"

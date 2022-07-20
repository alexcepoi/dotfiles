#! /usr/bin/env zsh

if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

# Load GNU dircolors if present.
if command -v dircolors &> /dev/null; then
  if [ -f ~/.dir_colors ]; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [ -f /etc/DIR_COLORS ]; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  else
    eval "$(dircolors -b)"
  fi
fi

# Clear screen.
reset() {
  command reset
  if [[ -n $TMUX ]]; then
    tmux clearhist
  fi
}

refresh() {
  if [[ -n $TMUX ]]; then
    env | \
      while read _env; do
        _envkey="$( cut -d '=' -f 1 <<< "$_env" )"
        _envval="$( cut -d '=' -f 2- <<< "$_env" )"
        tmux showenv -g $_envkey &> /dev/null && \
          tmux setenv -g $_envkey "$_envval"
        done
  fi
}

# History search.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# Plugins
if [ -f ~/.zgen/zgen.zsh ]; then
  source ~/.zgen/zgen.zsh

  if ! zgen saved; then
    zgen load "zsh-users/zsh-completions"
    zgen load "zsh-users/zsh-syntax-highlighting"

    zgen save
  fi
fi

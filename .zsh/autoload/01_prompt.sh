#! /usr/bin/env zsh

set_prompt() {
  GVIM_SERVER='GVIM'

  local G3_PROMPT="${PWD/#${HOME}/~}"
  PS1="%B%F{green}%m %F{blue}$G3_PROMPT %# %f%b%k"
  PS2="%B%F{green}%m %F{blue}$G3_PROMPT > %f%b%k"
}

# prompt hooks
set_title() {
  print -Pn "\e]0;${G3_BASE_PROMPT}${G3_BASE_PROMPT:+" "}$1\a"
}

precmd() {
  EXIT_CODE=$?
  if $ZSH_NEW_COMMAND && [[ $EXIT_CODE -ne 0 ]]; then
    >&2 echo "$fg[red]zsh: exit code: $EXIT_CODE$reset_color"
    ZSH_NEW_COMMAND=false
  fi
  set_prompt
  set_title "${SHELL##*/}"
}

preexec() {
  ZSH_NEW_COMMAND=true
  emulate -L zsh
  setopt extended_glob

  # command name only
  set_title "${1[(wr)^(*=*|-*)]:gs/%/%%}"
}

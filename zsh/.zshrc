# General settings
bindkey -e

autoload -Uz colors && colors
autoload -Uz select-word-style && select-word-style bash
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit

if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

# Completion settings
setopt noautomenu
LISTMAX=0

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' verbose true

if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false

# Aliases
alias ls='ls --color=auto'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# .bashrc.d
for file in  ~/.zsh/autoload/*(N); do
    source "$file"
done
for file in  ~/.zsh/autoload/local/*(N); do
    source "$file"
done

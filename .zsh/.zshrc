# General settings
bindkey -e

autoload -Uz colors && colors
autoload -Uz select-word-style && select-word-style bash
setopt EXTENDEDGLOB
autoload -Uz compinit && ( [[ -n ${ZDOTDIR}/.zcompdump(#qN.m-1)  ]] && compinit -C || compinit )
unsetopt EXTENDEDGLOB
autoload -Uz bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit

# Load any common interactive shell settings if present.
[ -r ~/.shrc ]  && source ~/.shrc

# Load rest of the settings from config files.
for file in  ~/.zsh/autoload/*(N); do
  source "$file"
done
for file in  ~/.zsh_local/autoload/*(N); do
  source "$file"
done

#! /usr/bin/env zsh

# Never prompt unless completions scroll more than one page.
LISTMAX=0

#  Don't cycle through options.
setopt no_auto_menu

# Do partial completions.
setopt completeinword
setopt complete_aliases

# Show command descriptions.
zstyle ':completion:*' verbose true

# On partial completions, highlight the character creating ambiguity.
zstyle ':completion:*' show-ambiguity "4;$color[fg-yellow]"

# Tab always autocompletes, never inserts a character.
zstyle ':completion:*' insert-tab false

# Caching completion results.
autoload -Uz compinit && compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Highlight completions for various commands.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

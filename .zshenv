export ZDOTDIR="$HOME/.zsh"
autoload -Uz colors && colors

# History settings
setopt incappendhistory histignorealldups histignorespace histreduceblanks
HISTSIZE=100000
SAVEHIST=100000
export HISTFILE=~/.zsh_history

# Time reporting
# REPORTTIME=5
TIMEFMT="$fg[yellow]Time: %E real %U user %S sys (%P cpu %MM ram)$reset_color"

# tmux helpers
tx_cmd() { tmux $@ }
tx() {
  if [ $# -eq 0 ]; then
    >&2 echo "Usage: ${0##*/} [tmux-args] session-name"
    tx_cmd ls
    return 1
  fi
  local name=${@:$#}
  local args=${@[1, -2]}

  DISPLAY=:1 tx_cmd ${args} new -A -s "${name}"
}

[ -r ~/.zsh_local/.zshenv ] && source ~/.zsh_local/.zshenv

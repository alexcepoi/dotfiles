#! /usr/bin/env zsh

if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

# Load GNU dircolors if present.
if command -v dircolors &> /dev/null; then
  if [ -f ~/.dir_colors ]; then
    eval "$(dircolors -b ~/.dir_colors)"
  else
    eval "$(dircolors -b)"
  fi
fi

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

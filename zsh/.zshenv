export ZDOTDIR="$HOME/.zsh"
autoload -Uz colors && colors

# Path settings
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# History settings
setopt incappendhistory histignorealldups histignorespace histreduceblanks
HISTSIZE=100000
SAVEHIST=100000
export HISTFILE=~/.zsh_history

# Time reporting
# REPORTTIME=5
TIMEFMT="$fg[yellow]Time: %E real %U user %S sys (%P cpu %MM ram)$reset_color"

# tmux helpers
tx() {
    if [ $# -eq 0 ]; then
        >&2 echo "Usage: ${0##*/} [tmux-args] session-name"
        return 1
    fi
    local name=${@:$#}
    local args=${@[1, -2]}

    # Make the temp directory if it doesn't exist
    local d="${HOME}/.tmp"
    if ! [ -d "${d}" ]; then
        mkdir -m 700 "${d}"
    fi

    local t="${USER}.ssh_auth_sock"
    if [ -z "${SSH_AUTH_SOCK}" ]; then
        # No auth sock; remove symlink, if any.
        rm -f -- "${d}/${t}"
    else
        # Construct expected symlink to point to auth sock.
        ln -snf -- "${SSH_AUTH_SOCK}" "${d}/${t}"
    fi

    if tmux list-sessions 2> /dev/null | grep -q "^${name}:"; then
        DISPLAY=:0 TERM=xterm-256color SSH_AUTH_SOCK="${d}/${t}" \
            tmux ${args} attach -t "${name}"
    else
        DISPLAY=:0 TERM=xterm-256color SSH_AUTH_SOCK="${d}/${t}" \
            tmux ${args} new -s "${name}"
    fi
}

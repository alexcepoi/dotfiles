#! /bin/sh

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

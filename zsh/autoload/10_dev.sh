#! /bin/sh

gvi() {
    if gvim --serverlist | grep -Fxqi $GVIM_SERVER; then
        command gvim --servername $GVIM_SERVER --remote-silent "$@"
    else
        command gvim --servername $GVIM_SERVER "$@"
    fi
}

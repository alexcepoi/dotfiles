#! /bin/sh

gvi() {
    if gvim --serverlist | grep -Fxqi $GVIM_SERVER; then
        if [[ "$#" -ne 0 ]]; then
            gvim --servername $GVIM_SERVER --remote-silent "$@"
        else
            gvim --servername $GVIM_SERVER --remote-silent \
                $(gvim --servername $GVIM_SERVER --remote-expr "expand('%:p')")
        fi
    else
        gvim --servername $GVIM_SERVER "$@"
    fi
}

#! /usr/bin/env zsh

gvi() {
  if gvim --serverlist | grep -Fxqi $GVIM_SERVER; then
    if [[ "$#" -ne 0 ]]; then
      gvim --servername $GVIM_SERVER --remote-wait-silent "$@"
    else
      gvim --servername $GVIM_SERVER --remote-wait-silent \
        $(gvim --servername $GVIM_SERVER --remote-expr "expand('%:p')")
    fi
  else
    gvim --servername $GVIM_SERVER "$@"
  fi
}

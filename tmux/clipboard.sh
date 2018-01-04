#!/bin/sh

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

copy_command() {
  clipboard=${1:-"primary"}
  if command_exists "pbcopy"; then
    if command_exists "reattach-to-user-namespace"; then
      echo "reattach-to-user-namespace pbcopy"
    else
      echo "pbcopy"
    fi
  elif command_exists "xsel"; then
    echo "xsel -i --$clipboard"
  else
    echo "true"
  fi
}

paste_command() {
  clipboard=${1:-"primary"}
  if command_exists "pbpaste"; then
    if command_exists "reattach-to-user-namespace"; then
      echo "reattach-to-user-namespace pbpaste"
    else
      echo "pbpaste"
    fi
  elif command_exists "xsel"; then
    echo "xsel -o --$clipboard"
  else
    echo "true"
  fi
}


tmux bind -Tcopy-mode-vi y send -X copy-pipe-and-cancel "$(copy_command clipboard)"
tmux bind -Tcopy-mode-vi Y send -X copy-pipe-and-cancel "$(copy_command primary)"
tmux bind -Tcopy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "$(copy_command primary)"
tmux bind p run "$(paste_command clipboard) | tmux load-buffer - ; tmux paste-buffer"
tmux bind P run "$(paste_command primary) | tmux load-buffer - ; tmux paste-buffer"
tmux bind -n MouseDown2Pane run "$(paste_command primary) | tmux load-buffer - ; tmux paste-buffer"

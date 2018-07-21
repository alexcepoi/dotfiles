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


# Mouse scrolling
tmux bind -n             WheelUpPane       if-shell -F -t = "#{mouse_any_flag}" "send -M" "if -Ft= \"#{pane_in_mode}\" \"send -M\" \"copy-mode -et=\""
tmux bind -Tcopy-mode-vi WheelUpPane       select-pane -t = \\\; send -X -N 5 scroll-up
tmux bind -Tcopy-mode-vi WheelDownPane     select-pane -t = \\\; send -X -N 5 scroll-down

# Mouse selection
tmux bind -n             MouseDown1Pane    select-pane -t = \\\; send -M
tmux bind -Tcopy-mode-vi MouseDown1Pane    select-pane -t = \\\; send -X clear-selection
tmux bind -n             MouseDrag1Pane    if-shell -F -t = "#{mouse_any_flag}" "if -Ft= \"#{pane_in_mode}\" \"copy-mode -M\" \"send -M\"" "copy-mode -M"
tmux bind -Tcopy-mode-vi MouseDrag1Pane    select-pane -t = \\\; send -X begin-selection

tmux bind -n             MouseDown1Status  select-window -t =
tmux bind -n             MouseDrag1Border  resize-pane -M

# Mouse primary clipboard
tmux bind -Tcopy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "$(copy_command primary)"
tmux bind -Tcopy-mode-vi MouseDragEnd2Pane send -X copy-pipe "$(copy_command primary)"
tmux bind -n             DoubleClick1Pane  select-pane -t = \\\; copy-mode -M \\\; send -X select-word \\\; send -X copy-pipe "$(copy_command primary)"
tmux bind -n             TripleClick1Pane  select-pane -t = \\\; copy-mode -M \\\; send -X select-line \\\; send -X copy-pipe "$(copy_command primary)"
tmux bind -n             MouseDown2Pane    run "$(paste_command primary) | tmux load-buffer - ; tmux paste-buffer"
tmux bind -Tcopy-mode-vi MouseDown2Pane    send -X

# Copy paste
tmux bind -Tcopy-mode-vi y                 send -X copy-pipe-and-cancel "$(copy_command clipboard)"
tmux bind -Tcopy-mode-vi Y                 send -X copy-pipe-and-cancel "$(copy_command primary)"
tmux bind                p                 run "$(paste_command clipboard) | tmux load-buffer - ; tmux paste-buffer"
tmux bind                P                 run "$(paste_command primary) | tmux load-buffer - ; tmux paste-buffer"

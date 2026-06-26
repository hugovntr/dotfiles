#!/usr/bin/env bash

set() {
  tmux set-option -gq "$1" "$2"
}

setw() {
  tmux set-window-option -gq "$1" "$2"
}

main() {

  background="terminal"
  gray_dark="color232"
  gray_muted="gray"
  gray_light="color239"
  border="color233"
  text_muted="color237"
  session_background="color253"

  # Status bar
  set status "on"
  set status-position "top"
  set status-justify "left"
  set status-style "fg=$gray_muted,bg=$background"
  set status-left "#[fg=#{?copy_cursor_line,$gray_dark,$gray_light},bg=#{?copy_cursor_line,3,$session_background},bold]   #S  #[default] "
  setw status-left-length "120"

  # Windows
  setw window-status-separator " #[fg=7,dim]|#[default] "     # Separator
  setw window-status-current-style "bold,fg=3,bg=$background" # Active window style
  setw window-status-current-format "   #I:#W "              # Active window format
  setw window-status-style "fg=$text_muted,bg=$background"    # Window style
  setw window-status-format "   #I:#W "                      # Window format

  # Pane border
  set pane-border-style "fg=$border"
  set pane-active-border-style "fg=$text_muted"
  set window-active-style "fg=$background,bg=$background"
  set window-style "fg=$text_muted,bg=$background"

  # Display messages
  set message-style "bg=$session_background,fg=0,bold"
}

main "$@"

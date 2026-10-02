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

  set @sl_separator "#[fg=$session_background,dim]|#[default]"

  set @sl_copy_mode_icon "#[fg=3]#[fg=0,bg=3] #[fg=3,bg=default]"
  set @sl_normal_mode_icon "#[fg=2]   "
  set @sl_mode_icon "#{?copy_cursor_line,#{@sl_copy_mode_icon},#{@sl_normal_mode_icon}}"

  set @sl_command "#[bold,fg=terminal]#{pane_current_command}#[default]"
  set @sl_path "#[fg=$text_muted,italics]#{s|$HOME|~|:pane_current_path}#[default]"

  set status-left " #{E:@sl_mode_icon}#[default] #{E:@sl_command} #{E:@sl_path} #[default] #[fg=$session_background,dim]|#[default] "
  setw status-left-length "120"

  # Windows
  setw window-status-separator " #[fg=color253,dim]|#[default] "     # Separator
  setw window-status-current-style "bold,fg=3,bg=$background" # Active window style
  setw window-status-current-format "    #W "              # Active window format
  setw window-status-style "fg=$text_muted,bg=$background"    # Window style
  setw window-status-format " (#I) #W "                      # Window format

  # Pane border
  set pane-border-style "fg=$border"
  set pane-active-border-style "fg=$text_muted"
  set window-active-style "fg=$background,bg=$background"
  set window-style "fg=$text_muted,bg=$background"

  # Display messages
  set message-style "bg=$session_background,fg=0,bold"
}

main "$@"

#!/usr/bin/env fish

# --- Author: https://mansoorbarri.com/tmux-ghostty-startup/

# ZSH
#SESSION_NAME="ghostty"

# Fish
set SESSION_NAME "ghostty"

# Source .zshrc to initialize zsh properly
#source ~/.zshrc
source ~/.config/fish/config.fish

tmux has-session -t $SESSION_NAME 2>/dev/null

# ZSH
# if [ $? -eq 0 ]; then
#   tmux attach-session -t $SESSION_NAME
# else
#   tmux new-session -s $SESSION_NAME -d
#   tmux attach-session -t $SESSION_NAME
# fi

# Fish
if count $argv -gt 0
  tmux new-session -s $SESSION_NAME -d
end
tmux attach-session -t $SESSION_NAME

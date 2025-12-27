#!/bin/sh

# 1. Add Homebrew path (Apple Silicon) to the environment
#    This ensures 'tmux' and 'fish' are found on M1/M2/M3 Macs.
#    On Intel Macs, this line is harmless.
export PATH="/opt/homebrew/bin:$PATH"

SESSION_NAME="ghostty"

# 2. Check if the session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

# 3. Capture the result ($? is the exit code of the last command)
if [ $? != 0 ]; then
  # Session doesn't exist, so create it (detached)
  tmux new-session -s "$SESSION_NAME" -d
fi

# 4. Attach to the session
#    (We use 'exec' so this script process is replaced by tmux,
#    saving a tiny bit of resources)
exec tmux attach-session -t "$SESSION_NAME"

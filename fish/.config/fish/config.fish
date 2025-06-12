# Unset greeting
set fish_greeting

# Environment
set -gx CDPATH $HOME/Projects
set -gx TERM xterm-256color
set -gx COLORTERM truecolor
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx FISH_CONFIG $XDG_CONFIG_HOME/fish
set -gx EDITOR nvim


# Homebrew
if test -f /opt/homebrew/bin/brew 
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
end

# Path
fish_add_path --append --path $HOME/bin $HOME/.local/bin

# Source colors
if test -f $XDG_CONFIG_HOME/colors/colors.sh
  source $XDG_CONFIG_HOME/colors/colors.sh
end

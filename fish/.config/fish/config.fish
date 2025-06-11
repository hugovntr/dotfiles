# Unset greeting
set fish_greeting

# Environment
set -gx CDPATH $HOME/Projects
set -gx TERM xterm-256color
set -gx COLORTERM truecolor
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx FISH_CONFIG $XDG_CONFIG_HOME/fish
set -gx EDITOR nvim

# Path
fish_add_path --append --path $HOME/bin $HOME/.local/bin

# Vim motion
source $XDG_CONFIG_HOME/fish/functions/vim-motion.fish

# Homebrew
if test -f /opt/homebrew/bin/brew 
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  fish_add_path --append --path /opt/homebrew/bin /opt/homebrew/sbin
end

# Initialize starship
set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship.toml
starship init fish | source

# Initialize zoxide
zoxide init --cmd cd fish | source

# FNM
fnm env --use-on-cd --shell fish | source

if status is-interactive
  # Check if we're in interactive shell
end

source $XDG_CONFIG_HOME/fish/aliases.fish
source $XDG_CONFIG_HOME/fish/abbr.fish

# Source colors
if test -f $XDG_CONFIG_HOME/colors/colors.sh
  source $XDG_CONFIG_HOME/colors/colors.sh
end

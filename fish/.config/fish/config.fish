# Unset greeting
set fish_greeting

# Environment
# set -gx CDPATH $HOME/Projects
set -gx TERM xterm-256color
set -gx COLORTERM truecolor
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx FISH_CONFIG $XDG_CONFIG_HOME/fish
set -gx EDITOR nvim


# Homebrew
if test -f /opt/homebrew/bin/brew 
  set -gx HOMEBREW_PREFIX "/opt/homebrew"
  set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
  set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
  fish_add_path /opt/homebrew/bin /opt/homebrew/sbin
else if test -d /home/linuxbrew/.linuxbrew
  set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
  set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
  set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
  fish_add_path "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
end

# Bun
if test -d $HOME/.bun
  fish_add_path --append --path $HOME/.bun/bin
end

# FNM
if test -d $XDG_DATA_HOME/fnm
  fish_add_path --append --path "$XDG_DATA_HOME/fnm"
   if not command -v node >/dev/null 2>&1
     set -gx FNM_DIR "$XDG_DATA_HOME/fnm/aliases/default/bin"
     if not contains "$FNM_DIR" $PATH
       fish_add_path --append --path "$FNM_DIR"
     end
   end
end

# Path
fish_add_path --append --path $HOME/bin $HOME/.local/bin

# Source colors
if test -f $XDG_CONFIG_HOME/colors/colors.sh
  source $XDG_CONFIG_HOME/colors/colors.sh
end

# CUDA
if test -d /usr/local/cuda
  fish_add_path --append --path "/usr/local/cuda/bin"
end

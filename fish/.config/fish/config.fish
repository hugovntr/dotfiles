# Unset greeting
set fish_greeting

# Environment
# set -gx CDPATH $HOME/Projects
set -gx TERM xterm-256color
set -gx COLORTERM truecolor
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx FISH_CONFIG $XDG_CONFIG_HOME/fish
set -gx DOTFILES $HOME/.dotfiles
set -gx EDITOR nvim

# Homebrew
if test -f /opt/homebrew/bin/brew
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX"
    contains -- "$HOMEBREW_PREFIX/bin" $PATH; or set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
else if test -d /home/linuxbrew/.linuxbrew
    set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
    contains -- "$HOMEBREW_PREFIX/bin" $PATH; or set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
else if test -f /usr/local/bin/brew
    set -gx HOMEBREW_PREFIX /usr/local
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX"
    contains -- "$HOMEBREW_PREFIX/bin" $PATH; or set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
end

# User paths (bun, go, local) — one loop, all builtins
for p in $HOME/.bun/bin $HOME/go/bin $HOME/bin $HOME/.local/bin
    test -d $p; and not contains -- $p $PATH; and set -gx PATH $PATH $p
end

# FNM
if test -d $XDG_DATA_HOME/fnm
    contains -- "$XDG_DATA_HOME/fnm" $PATH; or set -gx PATH $PATH "$XDG_DATA_HOME/fnm"
    # `type -q` is a builtin: no process spawn, unlike `command -v node`
    set -gx FNM_DIR "$XDG_DATA_HOME/fnm/aliases/default/bin"
    if not type -q node
        contains -- "$FNM_DIR" $PATH; or set -gx PATH $PATH "$FNM_DIR"
    end
end

# Source colors
if test -f $XDG_CONFIG_HOME/colors/colors.sh
    source $XDG_CONFIG_HOME/colors/colors.sh
end

# CUDA
if test -d /usr/local/cuda
    contains -- /usr/local/cuda/bin $PATH; or set -gx PATH $PATH /usr/local/cuda/bin
end

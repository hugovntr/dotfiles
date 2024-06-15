# Path configurations
export PATH="$HOME/.local/bin:$PATH"
export FORGE="$HOME/.config"
export XDG_CONFIG_HOME="$FORGE"
export DOTFILES="${XDG_CONFIG_HOME:-FORGE}"
export ZSH_CONFIG="${DOTFILES}/zsh"
export WEZTERM_CONFIG_FILE="${DOTFILES}/wezterm/wezterm.lua"

# True color configuration
export TERM=xterm-256color
export COLORTERM=truecolor

# macOS Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Initialize zinit
source "${ZSH_CONFIG}/init.zsh"

# Prompt / Starship
export STARSHIP_CONFIG="${DOTFILES}/starship.toml"
eval "$(starship init zsh)"

# ZSH plugins
source "${ZSH_CONFIG}/plugins.zsh"

# Default editor
export EDITOR='nvim'
# Disable vimcmd
bindkey -e

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=always $realpath'

# Load tools
source "${ZSH_CONFIG}/tools.zsh"

# Load Aliases
for file in ${ZSH_CONFIG}/aliases/*.zsh; do
  if [ -f "$file" ]; then
    source "$file"
  fi
done

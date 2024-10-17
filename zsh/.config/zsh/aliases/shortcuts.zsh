alias ls="ls --color"
alias dev="cd ~/Projects"
alias dsstore="find . -name '.DS_Store' -type f -delete"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"

# PHP Storm
alias s.="phpstorm ."
function phpstorm() {
	open -na "PhpStorm.app" --args "$@"
}

# WebStorm
alias w.="webstorm ."
function webstorm() {
	open -na "WebStorm.app" --args "$@"
}

# PyCharm
alias c.="pycharm ."
function pycharm() {
	open -na "PyCharm Professional Edition.app" --args "$@"
}

# Python
alias py="python"

# Neovim
alias n="nvim"

# Tmuxifier
alias tx="tmuxifier"

# Debug ZSH startup time
alias debugzsh="time zsh -i -c exit"

# Hyperfine
alias bench="hyperfine"

# Darwin-Rebuild
function drb() {
  local nix_path=$XDG_CONFIG_HOME/nix
  local dotfiles_path=$(readlink -f $XDG_CONFIG_HOME/zsh | xargs dirname | xargs dirname | xargs dirname )/nix
  cp $dotfiles_path/flake.nix $nix_path
  darwin-rebuild switch --flake $nix_path#macos
}

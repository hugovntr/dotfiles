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

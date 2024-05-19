# Git
alias add="git add -A"
function commit() { 
	git add -A
	git commit -S -m "$*"
}
alias push="git push"
alias pull="git pull"
alias fetch="git fetch --prune"
alias merged='git branch --merged | egrep -v "(^\*|master|main|canary)" | xargs git branch -d'

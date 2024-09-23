# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
cdpath=($HOME/Projects)

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias z='cd'
alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# alias md='mkdir -p'
# alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
# compdef _dirs d

# List directory contents

if (( $+commands[eza] )); then
  typeset -ag eza_params

  eza_params=('--git' '--icons' '--group' '--group-directories-first' '--color=always' '--color-scale=size' '--color-scale-mode=gradient' '--sort=modified')
  alias l='eza -lo --no-user --no-permissions $eza_params'
  alias lsa='eza -lah --total-size $eza_params'
  alias ll='eza --all -l --time-style=relative $eza_params'
  alias la='eza -lbhHigUmuSa $eza_params'
  alias lt='eza --tree -L 1 $eza_params'
  alias lt2='eza --tree -L 2 $eza_params'
  alias lt3='eza --tree -L 3 $eza_params'
  alias lt4='eza --tree -L 4 $eza_params'
  alias lt5='eza --tree -L 5 $eza_params'
  alias lt6='eza --tree -L 6 $eza_params'
  alias lt7='eza --tree -L 7 $eza_params'
  alias lt8='eza --tree -L 8 $eza_params'
  alias lt9='eza --tree -L 9 $eza_params'

else
  alias lsa='ls -lah'
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'

fi

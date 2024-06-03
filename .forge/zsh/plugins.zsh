# Tmux plugin configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_CONFIG="${DOTFILES}/tmux/tmux.conf"

zinit load zsh-users/zsh-autosuggestions

zi for \
  atload"zicompinit; zicdreplay" \
  blockf \
  lucid \
  wait \
  Aloxaf/fzf-tab

zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting


zi for \
  as "completions" \
  atload"zicompinit; zicdreplay" \
  atdelete"zinit cuninstall completions" \
  atpull'zinit creinstall -q "$PWD"' \
  blockf \
  lucid \
  wait \
  zsh-users/zsh-completions

zinit ice wait lucid
zinit snippet OMZP::golang

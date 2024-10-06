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

zi for \
  atload"zvm_config" \
  blockf \
  lucid \
  wait \
  jeffreytse/zsh-vi-mode

function zvm_config() {
  export ZVM_INIT_MODE=sourcing
  export ZVM_VI_INSERT_ESCAPE_BINDKEY=kl
  export ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
  export ZVM_VI_EDITOR=nvim
  zvm_bindkey vicmd "m" zle vi-forward-char
  zvm_bindkey vicmd "j" zle vi-backward-char
  zvm_bindkey vicmd "l" zle down-line-or-history
}

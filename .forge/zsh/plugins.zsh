# Tmux plugin configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_CONFIG="${DOTFILES}/tmux/tmux.conf"

zinit load zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit load Aloxaf/fzf-tab

zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting


# zinit wait lucid light-mode for \
#   as'completion' \
#   atdelete'zinit cuninstall completions' \
#   atload"zicompinit; zicdreplay" \
#   atpull'zinit creinstall -q "$PWD"' \
#   blockf \
#   id-as'auto' \
#   zsh-users/zsh-completions

zinit ice wait lucid
zinit snippet OMZP::golang

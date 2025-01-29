# Tmux plugin configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_CONFIG="${XDG_CONFIG_HOME}/tmux/tmux.conf"

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

my_zvm_vi_yank() {
    zvm_vi_yank
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_delete() {
    zvm_vi_delete
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_change() {
    zvm_vi_change
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_change_eol() {
    zvm_vi_change_eol
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_substitute() {
    zvm_vi_substitute
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_substitute_whole_line() {
    zvm_vi_substitute_whole_line
    echo -en "${CUTBUFFER}" | pbcopy
}

my_zvm_vi_put_after() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_put_after
    zvm_highlight clear # zvm_vi_put_after introduces weird highlighting
}

my_zvm_vi_put_before() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_put_before
    zvm_highlight clear # zvm_vi_put_before introduces weird highlighting
}

my_zvm_vi_replace_selection() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_replace_selection
    echo -en "${CUTBUFFER}" | pbcopy
}

function zvm_config() {
  export ZVM_INIT_MODE=sourcing
  export ZVM_VI_INSERT_ESCAPE_BINDKEY=kl
  export ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
  export ZVM_VI_EDITOR=nvim
  zvm_define_widget my_zvm_vi_yank
  zvm_define_widget my_zvm_vi_delete
  zvm_define_widget my_zvm_vi_change
  zvm_define_widget my_zvm_vi_change_eol
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before
  zvm_define_widget my_zvm_vi_substitute
  zvm_define_widget my_zvm_vi_substitute_whole_line
  zvm_define_widget my_zvm_vi_replace_selection

  zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
  zvm_bindkey vicmd 'P' my_zvm_vi_put_before
  zvm_bindkey vicmd 'S' my_zvm_vi_substitute_whole_line
  zvm_bindkey vicmd 'p' my_zvm_vi_put_after

  zvm_bindkey visual 'p' my_zvm_vi_replace_selection
  zvm_bindkey visual 'c' my_zvm_vi_change
  zvm_bindkey visual 'd' my_zvm_vi_delete
  zvm_bindkey visual 's' my_zvm_vi_substitute
  zvm_bindkey visual 'x' my_zvm_vi_delete
  zvm_bindkey visual 'y' my_zvm_vi_yank

  zvm_bindkey vicmd "m" zle vi-forward-char
  zvm_bindkey vicmd "j" zle vi-backward-char
  zvm_bindkey vicmd "l" zle down-line-or-history
}

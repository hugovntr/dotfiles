# Aliases

## Eza
if command -q eza
  set eza_params --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified
  alias l="eza -lo --no-user --no-permissions $eza_params"
  alias lsa="eza -lah --total-size $eza_params"
  alias ll="eza --all -l --time-style=relative $eza_params"
  alias la="eza -lbhHigUmuSa $eza_params"
  for i in (seq 1 9)
    alias "lt$i"="eza --tree -L $i $eza_params"
  end
  alias lt="lt1"
else
  alias lsa='ls -lah'
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'
end

## Directories
alias z='cd'

## Shortcuts
alias dev="cd $CDPATH"
alias dsstore="find . -name '.DS_Store' -type f -delete"
alias icloud="cd ~/Library/Mobile Documents/com~apple~CloudDocs/"
alias n="nvim"
alias bench="hyperfine"
alias mlx="$CDPATH/ai/mlx/.venv/bin/mlx_lm.generate --ignore-chat-template -m 2048"
alias colors="$XDG_CONFIG_HOME/colors/generate_palette.sh"

# Abbreviations

abbr ... '../..'
abbr .... '../../..'
abbr ..... '../../../..'
abbr ...... '../../../../..'


abbr 1 'cdn 1'
abbr 2 'cdn 2'
abbr 3 'cdn 3'
abbr 4 'cdn 4'
abbr 5 'cdn 5'
abbr 6 'cdn 6'
abbr 7 'cdn 7'
abbr 8 'cdn 8'
abbr 9 'cdn 9'

abbr gi 'git ai'
abbr gp 'git push'
abbr add 'git add'
abbr push 'git push'
abbr pull 'git pull'
abbr fetch 'git fetch --prune'
abbr merged 'git branch --merged | egrep -v "(^\*|master|main|canary)" | xargs git branch -d'

# Eza shortcuts
if command -q eza
  set --local eza_params --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified
  abbr l "eza -lo --no-user --no-permissions --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified"
  abbr lsa "eza -lah --total-size --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified"
  abbr ll "eza --all -l --time-style=relative --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified"
  abbr la "eza -lbhHigUmuSa --git --icons --group --group-directories-first --color=always --color-scale=size --color-scale-mode=gradient --sort=modified"
else
  abbr lsa 'ls -lah'
  abbr l   'ls -lah'
  abbr ll  'ls -lh'
  abbr la  'ls -lAh'
end

# Directory navigation
abbr z "cd"
abbr dev "cd $CDPATH"
abbr icloud "cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

# Utilities
abbr dsstore "find . -name '.DS_Store' -type f -delete"
abbr n "nvim"
abbr bench "hyperfine"
abbr mlx "$CDPATH/ai/mlx/.venv/bin/mlx_lm.generate --ignore-chat-template -m 2048"
abbr colors "$XDG_CONFIG_HOME/colors/generate_palette.sh"
abbr ef "exec fish"

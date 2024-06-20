# NodeJS
eval "$(fnm env --use-on-cd)"

# PyEnv
# Try to find pyenv, if it's not on the path
export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
if ! type pyenv > /dev/null && [ -f "${PYENV_ROOT}/bin/pyenv" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

# Lazy load pyenv
if type pyenv > /dev/null; then
    export PATH="${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}"
    function pyenv() {
        unset -f pyenv
        eval "$(command pyenv init -)"
        if [[ -n "${ZSH_PYENV_LAZY_VIRTUALENV}" ]]; then
            eval "$(command pyenv virtualenv-init -)"
        fi
        pyenv $@
    }
fi

# Tmuxifier
# -> Lazy loaded when calling the `tmuxifier` command/alias
export PATH="$FORGE/tmux/plugins/tmuxifier/bin:$PATH"
function tmuxifier() {
  unset -f tmuxifier
  eval "$(command tmuxifier init -)"
  tmuxifier $@
}

# pnpm
if [ -f "$HOME/.local/share/pnpm/pnpm" ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
else
  export PNPM_HOME="$HOME/Library/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$PATH:$HOME/bin
# -> Lazy loaded when calling the `bun` command
function bun() {
  unset -f bun
  if [ -s "$HOME/.bun/_bun" ]; then
    source "$HOME/.bun/_bun"
  fi
  bun $@
}

# GoLang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

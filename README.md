# dotfiles

## Requirements
- GNU Stow `brew install stow`
- WezTerm `brew install wezterm` _(optional)_
- Tmux `brew install tmux` _(optional)_


## Installation
> [!CAUTION]
> **Backup your existing installation before cloning this repository**

```bash
# Clone the repository
git clone https://github.com/hugovntr/dotfiles.git ~/.dotfiles

# Run stow to link all the files
cd ~/.dotfiles/ && stow .
```
Restart your shell once that's done

## Before you try
Because of the way my brain is set up, I don't use **vim** default navigation key bindings.
Instead, I use `jklm` (Left, Up, Down, Right).
This configuration is the same to switch between panes in tmux, or to resize panes.

### Nvim
- The leader key is mapped to `Space`

### Tmux
- The leader key is mapped to `Ctrl+Q`
_If you are using a mac, I strongly suggest that you remap `CapsLock` alone to `Escape` and when pressed with another key, to `Ctrl`. It keeps those fingers close to the home row_

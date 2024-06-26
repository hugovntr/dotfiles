# dotfiles

## Requirements
- GNU Stow `brew install stow`
- Starship `brew install starship`
- FZF `brew install fzf`
- Zoxide `brew install zoxide`
- WezTerm `brew install wezterm` _(optional)_
- Tmux `brew install tmux` _(optional)_
- Hyperfine `brew install hyperfine` *(optional)*


## Installation
> [!CAUTION]
> **Backup your existing installation before cloning this repository**

```bash
# Clone the repository
git clone https://github.com/hugovntr/dotfiles.git ~/.dotfiles

# Navigate to the dotfiles folder
cd ~/.dotfiles/
```
Once you are in the dotfiles folder, you may install the desired package(s).

For example, if you only want to install **neovim** you can do it like so:
```bash
stow nvim
```
And all the configuration will be symlinked to the appropriate folder in the system.

But, you can also install multiple packages at once:
```bash
stow nvim wezterm zsh
```

Restart your shell once that's done

## Before you try
Because of the way my brain is set up, I don't use **vim** default navigation key bindings.
Instead, I use `jklm` (Left, Up, Down, Right).
This configuration is the same to switch between panes in tmux, or to resize panes.

### Neovim
- The leader key is mapped to `Space`

### Tmux
- The leader key is mapped to `Ctrl+Q`
_If you are using a mac, I strongly suggest that you remap `CapsLock` alone to `Escape` and when pressed with another key, to `Ctrl`. It keeps those fingers close to the home row_

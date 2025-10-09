```
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║  Setup work environment on macOS
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  Made by: Hugo Ventura <https://github.com/hugovntr>
```                                                             

## Requirements
[Homebrew](brew.sh) **must** be installed on your system.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
> [!NOTE]
> The part of the script that is responsible for automatically installing homebrew is bugged and I haven't taken the time to debug it (mostly due to the fact that it requires manual user input)


## Installation
> [!CAUTION]
> **Backup your existing installation before cloning this repository**

```bash
# Clone the repository
git clone https://github.com/hugovntr/dotfiles.git ~/.dotfiles

# Navigate to the dotfiles folder
cd ~/.dotfiles/
```
Once you are in the dotfiles folder, you may run the `setup.sh` script.

First, ensure that the script has the correct `chmod`
```bash
chmod +x setup.sh ./.setup/utils.sh
```

Next, run the script:
```bash
./setup.sh
```

I advise you to restart your machine once it's completed

## Before you try
Because of the way my brain is set up, I don't use **vim** default navigation key bindings.
Instead, I use `jklm` (Left, Up, Down, Right).
This configuration is the same to switch between panes in tmux, or to resize panes.

### Neovim
- The leader key is mapped to `Space`

### Tmux
- The leader key is mapped to `Ctrl+Q`
_If you are using a mac, I strongly suggest that you remap `CapsLock` alone to `Escape` and when pressed with another key, to `Ctrl`. It keeps those fingers close to the home row_

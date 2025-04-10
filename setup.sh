#!/bin/bash

# Exit on error
set -e

# Logo
logo() {
  cat << "EOF"
  
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║  Setup work environment on macOS
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  Made by: Hugo Ventura <https://github.com/hugovntr>
                                                             
EOF
}
clear
logo

# Import utilities
source ./.setup/utils.sh

# Homebrew pre-requirements
ensure_homebrew
ensure_packages yq stow

# Ensure configuration exists
if [ ! -f "config.yml" ]; then
  echo "Error: config.yml is required"
  exit 1
fi

# Add taps
for tap in $(yq -r '.homebrew.taps[]' config.yml); do
  ensure_taps "${tap}"
done

# Add casks
for cask in $(yq -r '.homebrew.casks[]' config.yml); do
  ensure_casks "${cask}"
done

# Add packages
for pkg in $(yq -r '.homebrew.packages[]' config.yml); do
  ensure_packages "${pkg}"
done

# Stow the .config files
echo -n "Cleanup previous .config files... (skipped)"
failure
ensure_stow nvim starship tmux karabiner sketchybar aerospace yazi qmk ghostty zsh wezterm

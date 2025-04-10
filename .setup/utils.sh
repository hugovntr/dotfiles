#!/bin/bash

ensure_homebrew() {
  if [ ! -f "/opt/homebrew/bin/brew" ]; then
    echo -n "Homebrew is missing, installing..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh &> /dev/null
    success
  fi

  echo -n "Self-updating Homebrew..."
  if /opt/homebrew/bin/brew update &> /dev/null; then
    success
  else
    failure
    exit 1
  fi
}

ensure_packages() {
  local pkgs=("$@")

  for pkg in "${pkgs[@]}"; do
    echo -n "Installing ${pkg}..."
    if HOMEBREW_NO_AUTO_UPDATE=1 brew install "${pkg}" &> /dev/null; then
      success
    else
      failure
      exit 1
    fi
  done
}

ensure_taps() {
  local taps=("$@")

  for tap in "${taps[@]}"; do
    echo -n "Adding tap ${tap}..."
    if HOMEBREW_NO_AUTO_UPDATE=1 brew tap "${tap}" &> /dev/null; then
      success
    else
      failure
      exit 1
    fi
  done
}

ensure_casks() {
  local casks=("$@")
  
  for cask in "${casks[@]}"; do
    echo -n "Installing cask ${cask}..."
    if HOMEBREW_NO_AUTO_UPDATE=1 brew install --cask "${cask}" &> /dev/null; then
      success
    else
      failure
      exit 1
    fi
  done
}

ensure_stow() {
  local pkgs=("$@")
  
  for pkg in "${pkgs[@]}"; do
    echo -n "Linking dotfiles for ${pkg}..."
    if stow "${pkg}"; then
      success
    else
      failure
      exit 1
    fi
  done
}

success() {
  echo -e "\033[0;32m ✓ \033[0m"
}
failure() {
  echo -e "\033[0;31m ✕ \033[0m"
}

#!/bin/bash

ensure_homebrew() {
  if [ ! -f "/opt/homebrew/bin/brew" ]; then
    echo -n "Homebrew is missing, installing..."
    # The installer requires manual user input, so it must run interactively.
    # Download it to a temp file and execute it (previously the script was
    # downloaded and discarded, never executed).
    local installer
    installer="$(mktemp)"
    if curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "${installer}" \
      && /bin/bash "${installer}"; then
      rm -f "${installer}"
      success
    else
      rm -f "${installer}"
      failure
      exit 1
    fi
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
  local failed=()

  for pkg in "${pkgs[@]}"; do
    echo -n "Installing ${pkg}..."
    if HOMEBREW_NO_AUTO_UPDATE=1 brew install "${pkg}" &> /dev/null; then
      success
    else
      failure
      failed+=("${pkg}")
    fi
  done

  # Report every failure at once instead of aborting on the first one
  if [ "${#failed[@]}" -gt 0 ]; then
    echo "Failed to install: ${failed[*]}"
    return 1
  fi
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
info() {
  echo -e "\033[0;33m – \033[0m"
}

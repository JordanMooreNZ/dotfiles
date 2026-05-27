#!/usr/bin/env bash
#
# Idempotent dotfiles installer. Safe to run multiple times.
# Sets up Homebrew, packages, oh-my-zsh + plugins, powerlevel10k, and symlinks.

set -euo pipefail

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

info() { printf "\n\033[1;34m==> %s\033[0m\n" "$*"; }

# 1. Homebrew --------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Load brew into this shell (prefix-aware: Apple Silicon vs Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

info "Installing packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 2. oh-my-zsh + plugins + powerlevel10k -----------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Installing oh-my-zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

clone_if_missing() {
  local repo="$1" dest="$2"
  if [[ -d "$dest" ]]; then
    echo "  already present: $dest"
  else
    git clone --depth=1 "$repo" "$dest"
  fi
}

info "Installing zsh plugins and powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/romkatv/powerlevel10k              "$ZSH_CUSTOM/themes/powerlevel10k"

# 3. Symlink dotfiles ------------------------------------------------------
info "Symlinking dotfiles into \$HOME"
for f in .zshrc .zshenv .p10k.zsh .gitconfig .aliases; do
  ln -sfv "$DOTFILES_DIR/$f" "$HOME/$f"
done

info "Done. Open a new iTerm tab (or run: exec zsh)."
echo "Reminder: set the iTerm font to 'MesloLGS NF' — see README.md."

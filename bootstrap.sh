#!/bin/bash
set -e

# Make sure we're not running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please run as a normal user, not root"
  exit 1
fi

echo "Bootstrapping system dependencies..."
if ! command -v paru &> /dev/null; then
  echo "paru not found, installing..."
  sudo pacman -S --needed base-devel git
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru && makepkg -si --noconfirm
  rm -rf /tmp/paru
fi

# Ensure our core tools (including our new shell and VCS) are installed
paru -S --needed nushell chezmoi jujutsu

echo "Bootstrap complete!"
echo "Now run: chezmoi init --apply ssh://git@codeberg.org/qasimstatic/dotfiles.git"

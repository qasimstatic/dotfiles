#!/bin/bash
set -e

echo "Installing packages..."
paru -S --needed - < ~/packages.txt

echo "Installing chezmoi..."
paru -S --needed chezmoi

echo "Applying dotfiles..."
chezmoi init --apply ssh://git@codeberg.org/qasimsk20/dotfiles.git

echo "Done! Reboot or log back in."
echo "Then run 'sudo ./system-setup.sh' for system configs (bootloader, sddm)."

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

echo "Setting up GPG and Pass Secret Service..."
mkdir -p ~/.local/share/dbus-1/services
ln -sf /usr/share/dbus-1/services/pass-secret-service.service ~/.local/share/dbus-1/services/
mkdir -p ~/.gnupg
echo "pinentry-program /usr/bin/pinentry-qt" > ~/.gnupg/gpg-agent.conf
echo "disable-scdaemon" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 28800" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/gpg-agent.conf
systemctl --user enable --now pass-secret-service.service || true

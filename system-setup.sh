#!/bin/bash
set -e

echo "Configuring bootloader..."
sudo cp ~/dotfiles/boot/loader/loader.conf /boot/loader/loader.conf
sudo cp ~/dotfiles/boot/loader/entries/arch.conf /boot/loader/entries/arch.conf
sudo bootctl update 2>/dev/null || true

echo "Configuring vconsole..."
sudo cp ~/dotfiles/etc/vconsole.conf /etc/vconsole.conf

echo "Configuring SDDM..."
sudo cp ~/dotfiles/etc/sddm.conf.d/sddm.conf /etc/sddm.conf.d/sddm.conf

echo "Done! Reboot to apply TTY theme and SDDM."

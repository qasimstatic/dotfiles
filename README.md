# Dotfiles

<p align="center">
  <img src="thumbnails/thumb0.png" alt="Desktop overview"/>
</p>

## Preview

<table align="center">
  <tr>
    <td><img src="thumbnails/thumb1.png" alt="Fuzzel launcher"></td>
    <td><img src="thumbnails/thumb2.png" alt="Ghostty terminal"></td>
    <td><img src="thumbnails/thumb3.png" alt="Joshuto file manager"></td>
  </tr>
  <tr>
    <td><img src="thumbnails/thumb4.png" alt="Nushell shell"></td>
    <td><img src="thumbnails/thumb5.png" alt="Neovim editor"></td>
    <td><img src="thumbnails/thumb6.png" alt="Rmpc music player"></td>
  </tr>
</table>

## Stack

| Component | Application |
|-----------|-------------|
| **WM** | Hyprland |
| **Terminal** | Ghostty |
| **Shell** | Nushell|
| **Bar** | Waybar |
| **Launcher** | Fuzzel |
| **Editor** | Neovim|
| **File Manager** | Joshuto |
| **Music** | rmpc + mpd + mpd-discord-rpc |
| **System Monitor** | btop |
| **Theme** | Catppuccin Mocha (High Contrast)|

## Installation

```bash
# 1. Clone and run install script
git clone ssh://git@codeberg.org/qasimsk20/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh

# 2. System configs (requires sudo)
sudo ./system-setup.sh

# 3. Reboot
reboot
```

## Overview

- **Hyprland** No Animations and Minimal config
- **Ghostty** Catppuccin High Contrast and custom keybinds that immitate tmux prefix for ghostty-tabs
- **Waybar** Inspired by [ThePrimeagen](https://github.com/ThePrimeagen) and [typecraft-dev](https://github.com/typecraft-dev)
- **RMPC(mpd)** configured on top of [Sin-cy rmpc and mpd dotfiles](https://github.com/Sin-cy/dotfiles/tree/main/rmpc/.config/rmpc) along with mpc-discord-rpc
- **Nushell** native completions except carapace for git cargo etc.
- **Neovim** also inspired by [ThePrimeagen](https://github.com/ThePrimeagen) and [typecraft-dev](https://github.com/typecraft-dev)
- **Fuzzel** basic menu + cliphist 
- **Systemd user services** Hyprland with uswm so all autostart services are systemd managed
- **SDDM and TTY theming** with catppuccin high contrast

## System Requirements

- Arch Linux
- yay/paru
- systemd-boot

## Credits

- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [typecraft-dev](https://github.com/typecraft-dev)
- [ThePrimeagen](https://github.com/ThePrimeagen)
- [Sin-cy](https://github.com/Sin-cy/dotfiles/tree/main/rmpc/.config/rmpc)

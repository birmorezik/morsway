#!/bin/bash
. /etc/os-release
if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
    yay
    yay -S swayfx swaybg swaylock swayidle dunst kitty waybar wlogout grim wl-clipboard cliphist brightnessctl

elif [[ "$ID" == "debian" || "$ID_LIKE" == *"debian"* ]]; then
    sudo apt update
    sudo apt install swaybg swaylock swayidle dunst kitty waybar wlogout grim wl-clipboard cliphist brightnessctl
    sleep 5
    echo "For swayfx on Debian / Debian-based distros, please refer to official swayfx installation guide."
    echo "https://github.com/wlrfx/swayfx/blob/master/INSTALL-deb.md"
    sleep 2
    echo "If you wish to use these dotfiles without swayfx / eye candy, feel free to install sway instead; then remove the 'Swayfx' section from ~/.config/sway/config."

else
    echo "Sorry, but your distro isn't currently supported by the installer; please install swayfx and the requirements manually, then copy the config files to ~/.config"
fi

sleep 5

echo "Cloning dotfiles from github..."

set -e

REPO="https://github.com/birmorezik/morsway.git"
TMPDIR=$(mktemp -d)

git clone --depth=1 "$REPO" "$TMPDIR/morsway"

mkdir -p "$HOME/.config"

cp -r "$TMPDIR/morsway/sway"   "$HOME/.config/"
cp -r "$TMPDIR/morsway/waybar" "$HOME/.config/"
cp -r "$TMPDIR/morsway/kitty"  "$HOME/.config/"
cp -r "$TMPDIR/morsway/rofi"   "$HOME/.config/"
cp -r "$TMPDIR/morsway/dunst"  "$HOME/.config/"

rm -rf "$TMPDIR"

echo "morsway dotfiles for sway / swayfx installed!"

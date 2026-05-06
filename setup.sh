#!/bin/sh

# Download backgrounds
bg_file=lumon_bg.jpg
bg_dir=~/.local/share/backgrounds
bg_url=https://raw.githubusercontent.com/OldJobobo/omarchy-lumon-theme/refs/heads/master/backgrounds/01-united-in-severance.jpg

mkdir -p "$bg_dir"
wget -O "$bg_dir/$bg_file" "$bg_url"

#ln -sfv $PWD/alacritty ~/.config/
# ln -sfv $PWD/foot ~/.config/
# ln -sfv $PWD/i3status-rust ~/.config/
#ln -sfv $PWD/mako ~/.config/
# ln -sfv $PWD/sway ~/.config/
#ln -sfv $PWD/waybar ~/.config/
#ln -sfv $PWD/wofi ~/.config/

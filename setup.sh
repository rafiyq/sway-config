#!/bin/sh

ln -sfv $PWD/mako ~/.config/
ln -sfv $PWD/sway ~/.config/
ln -sfv $PWD/i3status-rust ~/.config/
ln -sfv $PWD/waybar ~/.config/
ln -sfv $PWD/wofi ~/.config/

case $1 in
    "gnome")
        echo "gnome profile"
        ;;
    *)
        ln -sfv $PWD/alacritty ~/.config/
        ln -sfv $PWD/kitty ~/.config/
        ln -sfv $PWD/mpv ~/.config/
        ln -sfv $PWD/gtk-3.0 ~/.config/
        ln -sfv $PWD/user-dirs.dirs ~/.config/
        ;;
esac

#!/bin/sh

set -e

# Download background
bg_file=lumon_bg.jpg
bg_dir=~/.local/share/backgrounds
bg_url=https://raw.githubusercontent.com/OldJobobo/omarchy-lumon-theme/refs/heads/master/backgrounds/01-united-in-severance.jpg

mkdir -p "$bg_dir"
wget -O "$bg_dir/$bg_file" "$bg_url"

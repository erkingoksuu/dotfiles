#!/bin/bash
dotfiles="/home/erkin/.temp-hyprland/dotfiles"

# share
sudo cp -r $dotfiles/share/. /usr/share/main-hyprland
echo ":: share installed"

# lib
sudo cp -r $dotfiles/lib/. /usr/lib/main-hyprland
echo ":: lib installed"

# bin
sudo cp $dotfiles/bin/main-hyprland-setup /usr/bin/main-hyprland-setup
echo ":: bin installed"

# apps
sudo cp $dotfiles/share/apps/com.main.welcome /usr/bin
sudo cp $dotfiles/share/apps/com.main.dotfilessettings /usr/bin
sudo cp $dotfiles/share/apps/com.main.hyprland.settings /usr/bin
echo ":: Apps installed"
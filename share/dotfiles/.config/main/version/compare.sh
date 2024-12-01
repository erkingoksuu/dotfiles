#!/bin/bash
# ------------------------------------------------------
# Compare installed version with used version
# ------------------------------------------------------

source ~/.config/main/version/library.sh

if [ -f /usr/share/main-hyprland/dotfiles/.config/main/version/name ] ;then
    installed_version=$(cat /usr/share/main-hyprland/dotfiles/.config/main/version/name)
    used_version=$(cat ~/.config/main/version/name)
    if [[ $(testvercomp $used_version $installed_version "<") == "0" ]] ;then
        notify-send "Please run main-hyprland-setup" "Installed version is newer then the version you're currently using." 
    fi
fi
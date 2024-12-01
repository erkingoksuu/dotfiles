#!/bin/bash
# Execute the script with ./sync version e.g., ./sync 2.5.2

if [ ! -z $1 ] ;then
    if [ -d ~/.temp-hyprland/"$1" ] ;then
        echo "Folder exists. Start rsync now ..."
        rsync -avhp -I --exclude-from=$HOME/.temp-hyprland/$1/lib/dev/excludes.txt ~/.temp-hyprland/dotfiles/share/dotfiles/  ~/dotfiles
    else 
        echo "Folder ~/.temp-hyprland/$1 not found."
    fi
else
    echo "No folder specified. Please use ./sync folder"
fi
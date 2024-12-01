#!/bin/bash
#  ____  _             _    
# / ___|| |_ __ _ _ __| |_     ___           __
# \___ \| __/ _` | '__| __|   / _ \___  ____/ /__
#  ___) | || (_| | |  | |_   / // / _ \/ __/  '_/ 
# |____/ \__\__,_|_|   \__| /____/\___/\__/_/\_\
#
# -----------------------------------------------------

# -----------------------------------------------------
# Quit all running nwg-dock-hyprland instances
# -----------------------------------------------------
killall nwg-dock-hyprland
pkill nwg-dock-hyprland
sleep 0.5

# -----------------------------------------------------
# Reload AGS
# -----------------------------------------------------

echo ":: Reload ags"
ags quit &
sleep 0.2
ags run &

# Check if nwg-dock-hyprland-disabled file exists
if [ ! -f $HOME/.cache/nwg-dock-hyprland-disabled ] ;then
    nwg-dock-hyprland -i 32 -w 5 -mb 14 -ml 10 -mr 10 -x -ico "$HOME/Pictures/app.png" -c "rofi -show drun" &
fi
#!/bin/bash
#  _____
# |_   _|__   __ _  __ _| | ___      ___           __
#   | |/ _ \ / _` |/ _` | |/ _ \    / _ \___  ____/ /__
#   | | (_) | (_| | (_| | |  __/   / // / _ \/ __/  '_/
#   |_|\___/ \__, |\__, |_|\___|  /____/\___/\__/_/\_\
#            |___/ |___/
#

if [ -f ~/.cache/nwg-dock-hyprland-disabled ] ;then
    rm ~/.cache/nwg-dock-hyprland-disabled
else
    touch ~/.cache/nwg-dock-hyprland-disabled
fi
~/.config/nwg-dock-hyprland/launch.sh &
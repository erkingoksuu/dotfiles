#!/bin/bash
#  ____  _             _    __        __          _                 
# / ___|| |_ __ _ _ __| |_  \ \      / /_ _ _   _| |__   __ _ _ __  
# \___ \| __/ _` | '__| __|  \ \ /\ / / _` | | | | '_ \ / _` | '__| 
#  ___) | || (_| | |  | |_    \ V  V / (_| | |_| | |_) | (_| | |    
# |____/ \__\__,_|_|   \__|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|    
#                                           |___/                   
# ----------------------------------------------------- 

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
killall waybar
pkill waybar
sleep 0.5

# ----------------------------------------------------- 
# Reload AGS
# -----------------------------------------------------

echo ":: Reload ags"
ags quit &
sleep 0.2
ags run &

# ----------------------------------------------------- 
# Default theme: /THEMEFOLDER;/VARIATION
# ----------------------------------------------------- 
themestyle="/theme;/theme/dark"

# ----------------------------------------------------- 
# Get current theme information from ~/.config/main/settings/waybar-theme.sh
# ----------------------------------------------------- 
if [ -f ~/.config/main/settings/waybar-theme.sh ]; then
    themestyle=$(cat ~/.config/main/settings/waybar-theme.sh)
else
    touch ~/.config/main/settings/waybar-theme.sh
    echo "$themestyle" > ~/.config/main/settings/waybar-theme.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo ":: Theme: ${arrThemes[0]}"

# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
config_file="config"
style_file="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f ~/.config/waybar/themes${arrThemes[0]}/config-custom ] ;then
    config_file="config-custom"
fi
if [ -f ~/.config/waybar/themes${arrThemes[1]}/style-custom.css ] ;then
    style_file="style-custom.css"
fi

# Check if waybar-disabled file exists
if [ ! -f $HOME/.cache/waybar-disabled ] ;then 
    waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
fi
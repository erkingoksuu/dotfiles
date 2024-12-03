# ------------------------------------------------------
# Clean up
# ------------------------------------------------------
echo "Finalizing"

# Create platform file if not exists
if [ ! -f $HOME/.config/main/settings/platform.sh ]; then
    touch $HOME/.config/main/settings/platform.sh
fi
echo "$install_platform" > $HOME/.config/main/settings/platform.sh
echo "platform.sh with $install_platform created"

# Cache file for holding the current wallpaper
cache_file="$HOME/.config/main/cache/current_wallpaper"
rasi_file="$HOME/.config/main/cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
    echo "Wallpaper cache file created"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    #echo "* { current-image: url("", height); }" > "$rasi_file"
    echo "Wallpaper rasi file created"
fi

# Check for running NetworkManager.service
if [[ $(systemctl list-units --all -t service --full --no-legend "NetworkManager.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "NetworkManager.service" ]];then
    echo "NetworkManager.service already running."
else
    sudo systemctl enable NetworkManager.service
    sudo systemctl start NetworkManager.service
    echo "NetworkManager.service activated successfully."    
fi

# Check for running bluetooth.service
if [[ $(systemctl list-units --all -t service --full --no-legend "bluetooth.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "bluetooth.service" ]];then
    echo "bluetooth.service already running."
else
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    echo "bluetooth.service activated successfully."    
fi

# Create default folder structure
xdg-user-dirs-update
echo "Clean up done"
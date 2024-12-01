# ------------------------------------------------------
# Apps Installation
# ------------------------------------------------------
_writeLogHeader "Apps"

# Create local applications folder if not exits
if [ ! -d $HOME/.local/share/applications/ ] ;then
    mkdir $HOME/.local/share/applications
    _writeLog 1 "$HOME/.local/share/applications created"
fi

# Installing the Main Apps
app_name="com.main.welcome"
sudo cp $apps_directory/$app_name.desktop /usr/share/applications
sudo cp $apps_directory/$app_name.png /usr/share/icons/hicolor/128x128/apps
sudo cp $apps_directory/$app_name /usr/bin/$app_name
_writeLog 1 "Main Welcome App installed successfully"

app_name="com.main.dotfilessettings"
sudo cp $apps_directory/$app_name.desktop /usr/share/applications
sudo cp $apps_directory/$app_name.png /usr/share/icons/hicolor/128x128/apps
sudo cp $apps_directory/$app_name /usr/bin/$app_name
_writeLog 1 "Main Settings App installed successfully"

app_name="com.main.hyprland.settings"
sudo cp $apps_directory/$app_name.desktop /usr/share/applications
sudo cp $apps_directory/$app_name.png /usr/share/icons/hicolor/128x128/apps
sudo cp $apps_directory/$app_name /usr/bin/$app_name
_writeLog 1 "Main Hyprland Settings App installed successfully"

_writeLogHeader "Hyprland Settings App"

# Execute hyprctl from the Settings app
if [ -f ~/.config/main-hyprland-settings/hyprctl.sh ] ;then
    _writeLog 0 "Starting restore from Main Hyprland Settings App"
    ~/.config/main-hyprland-settings/hyprctl.sh
fi
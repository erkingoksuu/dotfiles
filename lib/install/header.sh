# ------------------------------------------------------
# Header
# ------------------------------------------------------
_writeLogHeader "Installation"
_writeLog 0 "Installation started"

clear
echo -e "${GREEN}"
cat <<"EOF"
   __  _____  _____      __  ___       __  ____ __      
  /  |/  / / / / / | /| / / / _ \___  / /_/ _(_) /__ ___
 / /|_/ / /_/_  _/ |/ |/ / / // / _ \/ __/ _/ / / -_|_-<
/_/  /_/____//_/ |__/|__/ /____/\___/\__/_//_/_/\__/___/
                                                        
EOF
echo "for Hyprland"
echo -e "${NONE}"
echo "Version: $version"
echo "Platform: $install_platform" 
echo
if [[ $(_check_update) == "true" ]] ;then
    _writeLog 0 "An existing Backup Dotfiles installation detected."
    _writeMessage "This script will guide you through the update process of the Backup Dotfiles."
else
    _writeLog 0 "Initial installation of Backup Dotfiles started."
    _writeMessage "This script will guide you through the installation process of the Backup dotfiles."
fi
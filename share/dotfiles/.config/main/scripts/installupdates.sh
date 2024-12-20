#!/bin/bash
#  ___           _        _ _   _   _           _       _             
# |_ _|_ __  ___| |_ __ _| | | | | | |_ __   __| | __ _| |_ ___  ___  
#  | || '_ \/ __| __/ _` | | | | | | | '_ \ / _` |/ _` | __/ _ \/ __| 
#  | || | | \__ \ || (_| | | | | |_| | |_) | (_| | (_| | ||  __/\__ \ 
# |___|_| |_|___/\__\__,_|_|_|  \___/| .__/ \__,_|\__,_|\__\___||___/ 
#                                    |_|                              

sleep 1
clear
install_platform="$(cat ~/.config/main/settings/platform.sh)"
figlet -f smslant "Updates"
echo

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------

if gum confirm "DO YOU WANT TO START THE UPDATE NOW?" ;then
    echo
    echo ":: Update started."
elif [ $? -eq 130 ]; then
        exit 130
else
    echo
    echo ":: Update canceled."
    exit;
fi

# Check if platform is supported
case $install_platform in
    arch)
        aur_helper="$(cat ~/.config/main/settings/aur.sh)"

        _isInstalledAUR() {
            package="$1";
            check="$($aur_helper -Qs --color always "${package}" | grep "local" | grep "${package} ")";
            if [ -n "${check}" ] ; then
                echo 0; #'0' means 'true' in Bash
                return; #true
            fi;
            echo 1; #'1' means 'false' in Bash
            return; #false
        }

        $aur_helper

        if [[ $(_isInstalledAUR "flatpak") == "0" ]] ;then
            flatpak upgrade
        fi
    ;;
    fedora)
        sudo dnf upgrade
    ;;
    *)
        echo ":: ERROR - Platform not supported"
        echo "Press [ENTER] to close."
        read
    ;;
esac

notify-send "Update complete"
echo
echo ":: Update complete"
echo
echo "Press [ENTER] to close."
read
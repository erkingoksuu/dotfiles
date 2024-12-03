# ------------------------------------------------------
# Select platform
# ------------------------------------------------------
echo "Platform"

# Select the platform if not defined with parameter
if [ -z $install_platform ]; then
    echo "Please select your platform to install the Backup Dotfiles."
    if _checkCommandExists "gum"; then
        echo
        install_platform=$(gum choose "arch" "fedora" "CANCEL")
    else
        echo
        echo "1: arch"
        echo "2: fedora"
        echo "0: CANCEL"
        echo
        while true; do
            read -p "Please select your platform: " yn
            case $yn in
                1* )
                    install_platform="arch"
                break;;
                2* ) 
                    install_platform="fedora"
                break;;
                0* ) 
                    echo ":: Installation canceled"
                    exit;
                break;;
                * ) 
                    echo ":: Please select your platform."
                ;;
            esac
        done
    fi
fi

# Check if platform is supported
case $install_platform in
    arch)
        echo "Installation on Arch based platform"
    ;;
    fedora)
        echo "Installation on Fedora based platform"
    ;;
    CANCEL)
        echo ":: Setup canceled"
        exit
    ;;
    *)
        echo ":: Setup canceled"
        exit
    ;;
esac
echo
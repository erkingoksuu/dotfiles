#!/bin/bash
clear

repo="erkingoksuu/dotfiles"

# Get latest tag from GitHub
get_latest_release() {
    curl --silent "https://api.github.com/repos/$repo/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                                 # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                         # Pluck JSON value
}

# Check if package is installed
_isInstalled() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# Install required packages
_installPackages() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} is already installed.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]]; then
        echo "All packages are already installed.";
        return;
    fi;
    printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

choice=""

_define_setup_type() {
    _writeMessage "Please define setup type."
    echo
    _writeMessage "full: Run full installation"
    _writeMessage "dotfiles: Run the setup of the dotfiles only"
    echo
    choice=$(gum input --placeholder "Enter enter setup type")
    echo
    if [[ $choice == "full" || $choice == "dotfiles" ]]; then
        echo
        _writeLogTerminal 0 "Your chice is $choice"
        _confirm_setup_type
    else
        _writeMessage "Please choose correct one."
        _define_setup_type
    fi
}

_confirm_setup_type() {
    if [[ $choice == "full" ]] ;then
        if gum confirm "Do you want use this choice?" ;then
            ./backup-hyprland-setup -p arch -m full
        elif [ $? -eq 130 ]; then
            _writeCancel
            exit 130
        else
            _define_setup_type
        fi
    elif [[ $choice == "dotfiles" ]] ;then
        if gum confirm "Do you want use this choice?" ;then
            ./backup-hyprland-setup -p arch -m dotfiles
        elif [ $? -eq 130 ]; then
            _writeCancel
            exit 130
        else
            _define_setup_type
        fi
    fi
}

# Required packages for the installer
packages=(
    "wget"
    "unzip"
    "gum"
    "rsync"
    "git"
)

latest_version=$(get_latest_release)

# Some colors
GREEN='\033[0;32m'
NONE='\033[0m'

# Header
echo -e "${GREEN}"
cat <<"EOF"
   ____         __       ____       
  /  _/__  ___ / /____ _/ / /__ ____
 _/ // _ \(_-</ __/ _ `/ / / -_) __/
/___/_//_/___/\__/\_,_/_/_/\__/_/   
                                    
EOF
echo "Backup Dotfiles for Hyprland"
echo -e "${NONE}"
while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo ":: Installation started."
            echo
        break;;
        [Nn]* ) 
            echo ":: Installation canceled"
            exit;
        break;;
        * ) 
            echo ":: Please answer yes or no."
        ;;
    esac
done

# Create Downloads folder if not exists
if [ ! -d ~/Downloads ]; then
    mkdir ~/Downloads
    echo ":: Downloads folder created"
fi 

# Remove existing downloaded folder and zip files 
if [ -d $HOME/Downloads/dotfiles ]; then
    rm -rf $HOME/Downloads/dotfiles
fi

# Synchronizing package databases
sudo pacman -Sy
echo

# Install required packages
echo ":: Checking that required packages are installed..."
_installPackages "${packages[@]}";
echo

# Select the dotfiles version
echo "Please choose between: "
echo "- Backup Dotfiles for Hyprland Rolling Release (main branch including the latest commits)"
echo
version=$(gum choose "rolling-release" "CANCEL")
if [ "$version" == "rolling-release" ]; then
    echo ":: Installing Rolling Release"
    echo
    git clone --depth 1 https://github.com/erkingoksuu/dotfiles.git ~/Downloads/dotfiles
elif [ "$version" == "CANCEL" ]; then
    echo ":: Setup canceled"
    exit 130    
else
    echo ":: Setup canceled"
    exit 130
fi
echo ":: Download complete."
echo

# cd into dotfiles folder
cd $HOME/Downloads/dotfiles/bin/

# Start Spinner
gum spin --spinner dot --title "Starting setup now..." -- sleep 3

# Start setup
_define_setup_type
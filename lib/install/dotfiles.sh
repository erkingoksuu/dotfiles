#!/bin/bash

if [ -z $install_platform ]; then
    source $install_directory/packages/platform.sh
fi

# ----------------------------------------------------- 
# AUR Helper
# ----------------------------------------------------- 
if [ -z $aur_helper ] ;then
    source $install_directory/packages/aur.sh
fi

# ----------------------------------------------------- 
# Prepare files for the installation
# ----------------------------------------------------- 
source $install_directory/dotfiles/preparation.sh

# ----------------------------------------------------- 
# Copy files to target directory
# ----------------------------------------------------- 
source $install_directory/dotfiles/copy.sh

# ----------------------------------------------------- 
# Initialize pywal color scheme
# ----------------------------------------------------- 
source $install_directory/dotfiles/pywal.sh

# ----------------------------------------------------- 
# Final cleanup
# ----------------------------------------------------- 
source $install_directory/dotfiles/cleanup.sh

# ----------------------------------------------------- 
# Offer Reboot
# ----------------------------------------------------- 
source $install_directory/dotfiles/reboot.sh
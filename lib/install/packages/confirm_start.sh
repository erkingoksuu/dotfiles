# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
echo "Confirm installation"

if gum confirm "DO YOU WANT TO INSTALL THE REQUIRED PACKAGES FOR Backup Dotfiles?" ;then
    echo "Installation started"
elif [ $? -eq 130 ]; then
    echo ":: Setup canceled"
    exit 130
else
    echo ":: Setup canceled"
    exit;
fi
echo
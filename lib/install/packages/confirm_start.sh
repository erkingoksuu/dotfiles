# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
echo "Confirm installation"

if gum confirm "DO YOU WANT TO INSTALL THE REQUIRED PACKAGES FOR Backup Dotfiles?" ;then
    echo "Installation started"
elif [ $? -eq 130 ]; then
    _writeCancel
    exit 130
else
    _writeCancel
    exit;
fi
echo
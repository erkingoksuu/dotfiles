# ------------------------------------------------------
# Copy dotfiles
# ------------------------------------------------------
_writeLogHeader "Copy"

_copy_confirm() {
    if gum confirm "Do you want to install the prepared Backup Dotfiles now?" ;then
        _writeLog 1 "Copy started"
        rsync -avhp -I $HOME/Downloads/dotfiles/share/dotfiles/.config/ $HOME/.config/
    elif [ $? -eq 130 ]; then
        _writeCancel
        exit 130
    else
        _writeCancel
        exit
    fi
}

_writeHeader "Copy"

_copy_confirm
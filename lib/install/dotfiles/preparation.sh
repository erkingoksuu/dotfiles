# ------------------------------------------------------
# Prepare dotfiles
# ------------------------------------------------------
_writeLogHeader "Preparation"

# Check existing .config folder
if [ ! -d ~/.config ]; then
    mkdir ~/.config
    _writeLog 1 "$HOME/.config folder created."
fi
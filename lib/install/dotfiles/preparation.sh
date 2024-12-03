# ------------------------------------------------------
# Prepare dotfiles
# ------------------------------------------------------
echo "Preparation"

# Check existing .config folder
if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo "$HOME/.config folder created."
fi
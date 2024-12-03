# ------------------------------------------------------
# Diagnosis
# ------------------------------------------------------
echo "Diagnosis"

commands=(
    "dunst"
    "waybar"
    "hyprpaper"
    "hyprlock"
    "hypridle"
    "hyprshade"
    "wal"
    "gum"
    "wlogout"
    "ags"
    "magick"
    "waypaper"
)

missing_commands=""

_run_diagnosis(){
    for command in "${commands[@]}"; do
        if ! _checkCommandExists $command; then
            missing_commands+="$command "
        fi
    done
}

_run_diagnosis

if [[ ! -z $missing_commands ]]; then
    echo "Diagnosis"
    echo "Some required commands are not available:"
    for command in "${missing_commands[@]}"; do
        echo $command
    done
    echo
    echo "You can proceed but some features of the Backup Dotfiles will not work."
    echo "Please install the missing packages manually for your distribution."
    echo
    if gum confirm "Do you want to proceed?" ;then
        echo
    elif [ $? -eq 130 ]; then
        _writeCancel
        exit 130
    else
        _writeCancel
        exit
    fi
else
    echo "Required commands checked"
fi
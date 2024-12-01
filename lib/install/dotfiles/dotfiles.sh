# ------------------------------------------------------
# Define dotfiles folder
# ------------------------------------------------------
_writeLogHeader "Dotfiles"
_writeHeader "Dotfiles"

dot_folder=""
dot_files_update=1

_define_dotfiles_folder() {
    _writeMessage "You can change the folder name if wanted (please dont change if you want default folders)"
    echo
    dot_folder_tmp=$(gum input --value "$dot_folder" --placeholder "Enter your installation folder name")
    dot_folder=${dot_folder_tmp//[[:blank:]]/}
    echo $dot_folder
    if [[ $dot_folder == ".temp-hyprland" ]] ;then
        _writeLogTerminal 2 "The folder .temp-hyprland is not allowed."
        _define_dotfiles_folder
    else
        _confirm_dotfiles_folder
    fi
}

_confirm_dotfiles_folder() {
    if [ "$dot_folder" == "" ] ;then
        _writeLogTerminal 0 "The Backup Dotfiles will be installed to the default location"
    else
        _writeLogTerminal 0 "The Backup Dotfiles will be installed in ~/$dot_folder/.config"
        if [ -d ~/$dot_folder ] ;then
            _writeLogTerminal 0 "The folder ~/$dot_folder already exists and the files will be updated."
        fi
    fi

    if gum confirm "Do you want use this folder?" ;then
        _writeLogTerminal 1 "Backup Dotfiles will be installed"
    elif [ $? -eq 130 ]; then
        _writeCancel
        exit 130
    else
        _define_dotfiles_folder
    fi
}

if [ -z $automation_dotfilesfolder ] ;then
    if [ -f ~/.config/main/settings/dotfiles-folder.sh ] ;then
        _writeLogTerminal 0 "An existing Backup Dotfiles folder has been detected: ~/$(cat ~/.config/main/settings/dotfiles-folder.sh)"
        _writeLogTerminal 0 "You can update your existing Backup Dotfiles in $(cat ~/.config/main/settings/dotfiles-folder.sh) or install in a new folder."
        echo
        if gum confirm "Do you want to start the update in ~/$(cat ~/.config/main/settings/dotfiles-folder.sh)"; then
            dot_folder=$(cat ~/.config/main/settings/dotfiles-folder.sh)
            dot_files_update=0
        elif [ $? -eq 130 ]; then
            _writeCancel
            exit 130
        else
            _define_dotfiles_folder
        fi
    fi

    if [ $dot_files_update == "0" ] ;then
        _writeLogTerminal 0 "Update will be executed in ~/$dot_folder"
        echo
    else
        _confirm_dotfiles_folder
    fi
else
    dot_folder=$automation_dotfilesfolder
    _writeLogTerminal 0 "AUTOMATION: Installation folder set to ~/$automation_dotfilesfolder"
fi
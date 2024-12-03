# ------------------------------------------------------
# Copy dotfiles
# ------------------------------------------------------
echo "Copy"

_copy_confirm() {
    if gum confirm "Do you want to install the prepared Backup Dotfiles now?" ;then
        echo "Copy started"

        src_dir="$HOME/Downloads/dotfiles/share/dotfiles/.config/"
        dest_dir="$HOME/.config/"
        for item in $(find "$src_dir" -mindepth 1 -printf "%P\n"); do
            src_item="$src_dir$item"
            dest_item="$dest_dir$item"
            if [[ -f "$src_item" && -f "$dest_item" ]]; then
                echo "Delete file: $dest_item"
                rm "$dest_item"
            elif [[ -d "$src_item" && -d "$dest_item" ]]; then
                echo "Delete folder: $dest_item"
                rm -rf "$dest_item"
            fi
        done

        echo "Copying Dotfiles..."
        rsync -avhr -I "$src_dir" "$dest_dir"

        # Create Pictures folder if not exists
        if [ ! -d ~/Pictures ]; then
            mkdir ~/Pictures
            echo ":: Pictures folder created"
        fi 

        src_dir="$HOME/Downloads/dotfiles/share/wallpapers/"
        dest_dir="$HOME/Pictures/"
        for item in $(find "$src_dir" -mindepth 1 -printf "%P\n"); do
            src_item="$src_dir$item"
            dest_item="$dest_dir$item"
            if [[ -f "$src_item" && -f "$dest_item" ]]; then
                echo "Delete file: $dest_item"
                rm "$dest_item"
            elif [[ -d "$src_item" && -d "$dest_item" ]]; then
                echo "Delete folder: $dest_item"
                rm -rf "$dest_item"
            fi
        done

        echo "Copying Wallpapers..."
        rsync -avhr -I "$src_dir" "$dest_dir"
        echo "All copied."
    elif [ $? -eq 130 ]; then
        echo ":: Setup canceled"
        exit 130
    else
        echo ":: Setup canceled"
        exit
    fi
}

echo "Copy"

_copy_confirm
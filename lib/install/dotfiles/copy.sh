# ------------------------------------------------------
# Copy dotfiles
# ------------------------------------------------------
_writeLogHeader "Copy"

_copy_confirm() {
    if gum confirm "Do you want to install the prepared Backup Dotfiles now?" ;then
        _writeLog 1 "Copy started"
        # Kaynak ve hedef dizinleri
        src_dir="$HOME/Downloads/dotfiles/share/dotfiles/.config/"
        dest_dir="$HOME/.config/"
        # Kaynak dizinindeki tüm dosya ve klasörleri döngüyle işleyin
        for item in $(find "$src_dir" -mindepth 1 -printf "%P\n"); do
            # Kaynak öğenin tam yolu
            src_item="$src_dir$item"
            # Hedefteki karşılık gelen öğe
            dest_item="$dest_dir$item"
            if [[ -f "$src_item" && -f "$dest_item" ]]; then
                # Eğer kaynak ve hedef dosyaysa
                echo "Dosya siliniyor: $dest_item"
                rm "$dest_item"
            elif [[ -d "$src_item" && -d "$dest_item" ]]; then
                # Eğer kaynak ve hedef klasörse
                echo "Klasör siliniyor: $dest_item"
                rm -rf "$dest_item"
            fi
        done

        # rsync ile kaynak dosya ve klasörlerini hedefe kopyala
        echo "Dosyalar ve klasörler kopyalanıyor..."
        rsync -avhr -I "$src_dir" "$dest_dir"
        echo "Kopyalama işlemi tamamlandı."
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
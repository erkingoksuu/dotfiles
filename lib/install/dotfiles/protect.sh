# Check .config
_writeLogHeader "Protect"

if [ -d ~/$dot_folder/.config ]; then 
    files=$(ls -a ~/$dot_folder/.config)
    for f in $files; do
        if [ ! "$f" == "." ] && [ ! "$f" == ".." ]; then
            if [ -d  ~/$dot_folder/.config/$f ] ;then
                _writeLog 0 "Checking for directory ~/.config/$f"
                if [ -f $HOME/.config/$f/PROTECTED ]; then
                    if [ -d $temp_directory/$version/.config/$f ]; then
                        _writeLog 0 "Folder ~/.config/$f is protected"
                        rm -rf $temp_directory/$version/.config/$f/
                    fi
                fi
            fi
        fi
    done
fi
# ------------------------------------------------------
# Prepare dotfiles
# ------------------------------------------------------
_writeLogHeader "Preparation"

# Check existing .config folder
if [ ! -d ~/.config ]; then
    mkdir ~/.config
    _writeLog 1 "$HOME/.config folder created."
fi

# Create required folder structure
_writeLog 0 "Preparing temporary folders for the installation."
if [ ! -d $temp_directory ] ;then
    mkdir $temp_directory
    _writeLog 1 "$temp_directory folder created."
fi
if [ ! -d $temp_directory/$version ] ;then
    mkdir $temp_directory/$version
    _writeLog 1 "$temp_directory/$version folder created."
else
    _writeLog 1 "The folder $temp_directory/$version already exists from previous installations."
    rm -rf $temp_directory/$version
    mkdir $temp_directory/$version
    _writeLog 1 "Clean build prepared for the installation."
fi
if [ ! -d $temp_directory/library ] ;then
    mkdir $temp_directory/library
    _writeLog 1 "library folder created"
fi

# Copy files to the destination
rsync -a -I --exclude-from=$includes_directory/excludes.txt $share_directory/dotfiles/. $temp_directory/$version/

# Check copy success
if [[ $(_isFolderEmpty $temp_directory/$version/) == 0 ]] ;then
    _writeLogTerminal 2 "AN ERROR HAS OCCURED. Preparation of $temp_directory/$version/ failed" 
    _writeLog 2 "Please check that rsync is installad on your system."
    _writeLog 2 "Execution of rsync -a -I --exclude-from=$includes_directory/excludes.txt . $temp_directory/$version/ is required."
    exit
fi
_writeLog 1 "Backup Dotfiles $version successfully prepared in $temp_directory/$version/"

# Copy hook.tpl if hook.sh not exists
if [ ! -f $temp_directory/hook.sh ] ;then
    cp $template_directory/hook.tpl $temp_directory/
    _writeLog 1 "hook.tpl created"
else
    chmod +x $temp_directory/hook.sh
    _writeLog 1 "hook.sh already exists"
fi

# Copy post.tpl if post.sh not exists
if [ ! -f $temp_directory/post.sh ] ;then
    cp $template_directory/post.tpl $temp_directory/
    _writeLog 1 "post.tpl created"
else
    chmod +x $temp_directory/post.sh
    _writeLog 1 "post.sh already exists"
fi

# Copy automation.tpl
cp $template_directory/automation.tpl $temp_directory/
_writeLog 1 "automation.tpl created"

# Copy activate.sh
cp $install_directory/activate.sh $temp_directory/
chmod +x $temp_directory/activate.sh
_writeLog 1 "activate.sh updated"

# Prepare library folder
cp $template_directory/scripts.tpl $temp_directory/library/scripts.sh
_writeLog 1 "scripts.sh for $version updated in $temp_directory/library"

# Replace version
SEARCH="BACKUPVERSION"
REPLACE="$version"
sed -i "s/$SEARCH/$REPLACE/g" $temp_directory/library/scripts.sh

# Replace temp_directory
SEARCH="BACKUPDIRECTORY"
REPLACE="$temp_directory"
sed -i "s|$SEARCH|$REPLACE|g" $temp_directory/library/scripts.sh

if [ $install_platform == "arch" ]; then
    echo "$aur_helper" > $temp_directory/$version/.config/main/settings/aur.sh
    if [ -f ~/.config/temp/settings/aur.sh ] ;then
        echo "$aur_helper" > $HOME/.config/main/settings/aur.sh
    fi
    _writeLog 1 "AUR Helper updated with $aur_helper"
fi

# Write dot folder into settings
echo "$dot_folder" > $temp_directory/$version/.config/main/settings/dotfiles-folder.sh
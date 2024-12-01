# ------------------------------------------------------
# Helper functions for hook and post
# ------------------------------------------------------
version="BACKUPVERSION"
temp_directory="BACKUPDIRECTORY"

# ------------------------------------------------------
# Protect files or folder from been overwritten by an update
# ------------------------------------------------------
_protect() {
    echo ":: protect $1"
    if [ -d $temp_directory/$version/$1 ] ;then
        rm -rf $temp_directory/$version/$1
        echo ":: Folder $1 protected"
    elif [ -f $temp_directory/$version/$1 ] ;then
        rm $temp_directory/$version/$1
        echo ":: File $1 protected"
    else 
        echo "$1 not found"
    fi
}
# Check for legacy folders
if [ -d ~/dotfiles-versions ] ;then
    mv ~/dotfiles-versions $temp_directory
fi
if [ -d ~/.temp-dotfiles ] ;then
    mv ~/.temp-dotfiles $temp_directory
fi
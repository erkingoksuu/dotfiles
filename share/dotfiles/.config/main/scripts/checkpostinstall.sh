if [ -f ~/.cache/main-post-install ] ;then
    terminal=$(cat ~/.config/main/settings/terminal.sh)
    $terminal -e ~/.config/main/postinstall.sh
    rm ~/.cache/main-post-install
    com.main.welcome
else
    echo ":: Post installation script already executed"
    exit
fi
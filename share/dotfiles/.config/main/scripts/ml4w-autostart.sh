#!/bin/bash

# Compare installed version with running dotfiles
if [ -f ~/.config/main/version/compare.sh ] ;then
    $HOME/.config/main/version/compare.sh
fi

# Start Main Welcome App
if [ ! -f $HOME/.cache/main-welcome-autostart ] ;then
    echo ":: Starting Main Welcome App ..."
    sleep 2
    com.main.welcome
else
    echo ":: Autostart of Main Welcome App disabled."
fi
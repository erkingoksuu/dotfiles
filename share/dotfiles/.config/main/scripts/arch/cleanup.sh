#!/bin/bash
clear
aur_helper="$(cat ~/.config/main/settings/aur.sh)"
figlet -f smslant "Cleanup"
echo
$aur_helper -Scc
# ------------------------------------------------------
# Reboot
# ------------------------------------------------------
echo "Reboot"
echo "Done"
echo "A reboot of your system is recommended."
echo
if gum confirm "Do you want to reboot your system now?" ;then
    gum spin --spinner dot --title "Rebooting now..." -- sleep 3
    systemctl reboot
elif [ $? -eq 130 ]; then
    _writeCancel
    exit 130
else
    _writeCancel
    exit 130
fi
echo
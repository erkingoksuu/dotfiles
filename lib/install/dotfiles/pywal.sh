# ------------------------------------------------------
# init pywal with wallpaper
# ------------------------------------------------------
echo "Pywal"
if [ ! -f ~/.cache/wal/colors-hyprland.conf ]; then
    wal -ei ~/wallpaper/hyprland.jpg
    echo "Pywal and templates activated."
else
    echo "Pywal already activated."
fi
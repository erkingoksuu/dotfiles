#!/bin/bash
# ------------------------------------------------------
# Check for updates
# ------------------------------------------------------

source ~/.config/main/version/library.sh

# Get latest tag from GitHub
get_latest_release() {
    v_online=$(curl --silent "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=ml4w-hyprland-git")
    v_full_online=$(grep -m 1 'pkgver' <<< $v_online | sed 's/^$/pkgver/')
    echo ${v_full_online/pkgver=/}
}

# Check for internet connection
if ping -q -c 1 -W 1 google.com >/dev/null; then
    version=$(cat ~/.config/main/version/name)
    online=$(get_latest_release "erkingoksuu/dotfiles")
    echo $version "<" $online
    testvercomp $version $online "<"
else
    # Network is down
    echo "1"
fi
# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------

if [ $install_platform = "arch" ]; then
    echo "AUR"

    yay_installed="false"
    paru_installed="false"
    aur_helper=""

    _installYay() {
        _installPackages "base-devel"
        SCRIPT=$(realpath "$0")
        temp_path=$(dirname "$SCRIPT")
        git clone https://aur.archlinux.org/yay.git ~/Downloads/yay
        cd ~/Downloads/yay
        makepkg -si
        cd $temp_path
        echo "yay has been installed successfully."
    }

    _installParu() {
        _installPackages "base-devel"
        SCRIPT=$(realpath "$0")
        temp_path=$(dirname "$SCRIPT")
        git clone https://aur.archlinux.org/paru.git ~/Downloads/paru
        cd ~/Downloads/paru
        makepkg -si
        cd $temp_path
        echo "paru has been installed successfully."
    }

    _selectAURHelper() {
        echo "AUR Helper"
        echo "Please select your preferred AUR Helper"
        echo
        aur_helper=$(gum choose "yay" "paru")
        if [ -z $aur_helper ] ;then
            _selectAURHelper
        fi
        echo "Using $aur_helper as AUR Helper"
    }

    _checkAURHelper() {
        if command -v "yay" > /dev/null; then
            echo "yay is installed"
            yay_installed="true"
        fi
        if command -v "paru" > /dev/null; then
            echo "paru is installed"
            paru_installed="true"
        fi
        if [[ $yay_installed == "true" ]] && [[ $paru_installed == "false" ]] ;then
            echo "Using AUR Helper yay"
            aur_helper="yay"
        elif [[ $yay_installed == "false" ]] && [[ $paru_installed == "true" ]] ;then
            echo "Using AUR Helper paru"
            aur_helper="paru"
        elif [[ $yay_installed == "false" ]] && [[ $paru_installed == "false" ]] ;then
            _selectAURHelper
            if [[ $aur_helper == "yay" ]] ;then
                _installYay
            else
                _installParu
            fi
        else
            _selectAURHelper
        fi
    }

    _checkAURHelper
fi
# ------------------------------------------------------
# Required packages
# ------------------------------------------------------
echo "Required packages"

# Required packages for the installer
source $packages_directory/$install_platform/installer.sh

# Install packages which required
echo "Checking required packages for the installer..."
_installPackages "${packages[@]}";
echo
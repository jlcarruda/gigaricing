## Variables
NODE_VERSION="18"
VIDEO_DRIVER="xf86-video-vmware"

## Updating and installing packages
echo "Installing packages ..."
pacman -Sy
pacman -Sy --noconfirm git xorg-server curl qtle alacritty neovim lazygit python-pywal

#### Driver install
# Choose which driver to install uncomenting the line below
#
# AMD
# pacman -S xf86-video-amdgpu
#
# Nvidia
# pacman -S nvidia
#
# VMWare
pacman -S xf86-video-vmware
#

## Install NVM
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

echo "Configuring X..."
Xorg :0 -configure
cp /root/xorg.conf.new /etc/X11/xorg.conf


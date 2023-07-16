## Variables
VERSION="1.0.0"
NODE_VERSION="18"
VIDEO_DRIVER="xf86-video-vmware"
BASE_PACKAGES_FILE='base-packages.txt'


function base ()
{
  echo "::::: Installing base packages :::::"
  while read -r package; do
    echo "Installing ${package}..."
    sudo pacman -S --noconfirm "$package"
  done < "$BASE_PACKAGES_FILE"
}

function paru_install(){
  echo "::::: Installing paru AUR helper :::::"
  git clone https://aur.archlinux.org/paru.git 
  cd paru 
  makepkg -si --noconfirm
  cd ..
  rm -rf paru
}


installMenu(){
  CHOICES=$(whiptail --menu "GIGA Rice Installation" ${r} ${c} 5 \
  "Install Base Packages" " " \
  "Install Pip Packages" " " \
  "Install AUR Packages" " " \
  "Copy all Dotfiles" " " \
  "Post Installation" " " 3>&1 1>&2 2>&3)

  for CHOICE in $CHOICES; do
    case "$CHOICE" in
    "1")
      echo "Option 1 was selected"
      #baseInstall >&2
      ;;
    "2")
      echo "Option 2 was selected"
      ;;
    "3")
      echo "Option 3 was selected"
      ;;
    "4")
      echo "Option 4 was selected"
      ;;
    *)
      echo "Unsupported item $CHOICE!" >&2
      exit 1
      ;;
    esac
  done

}

installMenu

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
#pacman -S xf86-video-vmware
#

## Install NVM
#echo "Installing NVM..."
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

#echo "Configuring X..."
#Xorg :0 -configure
#cp /root/xorg.conf.new /etc/X11/xorg.conf


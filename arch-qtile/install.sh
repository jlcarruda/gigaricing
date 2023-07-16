## Variables
VERSION="1.0.0"
NODE_VERSION="18"
VIDEO_DRIVER="xf86-video-vmware"
BASE_PACKAGES_FILE='base-packages.txt'
AUR_PACKAGES_FILE='aur-packages.txt'
PIP_PACKAGES_FILE="pip-packages.txt"

screen_size=$(stty size 2>/dev/null || echo 24 80)
rows=$(echo $screen_size | awk '{print $1}')
columns=$(echo $screen_size | awk '{print $2}')

# Dialog Screen
r=$(( rows / 2 ))
c=$(( columns / 2 ))

check_install_dependencies() {
  sudo pacman -S --noconfirm extra/libnewt python-pip "$VIDEO_DRIVER"
}

install_base_packages()
{
  echo "::::: Installing base packages :::::"
  while read -r package; do
    echo "Installing ${package}..."
    sudo pacman -S --noconfirm "$package"
  done < "$BASE_PACKAGES_FILE"

  echo ":::"
  echo "Instalation complete!"
}

baseInstall(){
  whiptail --msgbox --backtitle "GIGA Installer $VER" --title "Base Packages Install" "The base packages needed for GIGA to work will be installed now \n \n Click OK to Continue" ${r} ${c}
    
  whiptail --title "Package Installation" --gauge "Installing ..." 6 50 0 < <(install_base_packages) 2>&1
}

paru_install(){
  echo "::::: Installing paru AUR helper :::::"
  git clone https://aur.archlinux.org/paru.git 
  cd paru 
  makepkg -si --noconfirm
  cd ..
  rm -rf paru
}

install_aur_packages()
{
  echo "::::: Installing AUR Packages :::::"
  while read -r package; do
    echo "Installing AUR package ${package}..."
    paru -S --noconfirm "$package"
  done < "$AUR_PACKAGES_FILE"

  echo ":::"
  echo "Instalation complete!"
}

aur_install(){
  whiptail --msgbox --backtitle "GIGA Installer $VER" --title "AUR Packages Install" "The base packages needed for GIGA to work will be installed now \n \n Click OK to Continue" ${r} ${c}
    
  whiptail --title "AUR Package Installation" --gauge "Installing ..." 6 50 0 < <(install_aur_packages) 2>&1
}

install_pip_packages()
{
  TOTAL_PACKAGES=$(wc -l < "$PIP_PACKAGES_FILE")
  count=0
  
  while read -r PACKAGE; do
    ((count++))

    pip install -r "${$PIP_PACKAGES_FILE}" --break-system-packages

    PERCENTAGE=$((count * 100 / TOTAL_PACKAGE))

    echo "::: "
    echo "Installing $PACKAGE..."
    echo "$PERCENTAGE"
    sleep 1
  done < "$PIP_PACKAGES_FILE"

  echo "::: "
  echo "Installation complete!"
}

pip_install() {
  whiptail --msgbox --backtitle "GIGA Installer $VER" --title "Pip Packages Install" "The base packages needed for GIGA to work will be installed now \n \n Click OK to Continue" ${r} ${c}
    
  whiptail --title "Pip Package Installation" --gauge "Installing ..." 6 50 0 < <(install_pip_packages) 2>&1
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
      base_install >&2
      ;;
    "2")
      pip_install >&2
      ;;
    "3")
      paru_install >&2
      aur_install >&2
      ;;
    "4")
      ;;
    *)
      echo "Unsupported item $CHOICE!" >&2
      exit 1
      ;;
    esac
  done
}

check_install_dependencies
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


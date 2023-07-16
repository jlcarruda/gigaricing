../ascii-art.sh
echo "#################################################"
echo "#############  CONFIGURE ########################"
echo "###################### RICE #####################"
echo "##### omzsh, qtile, dotfiles and stuff ##########"
echo "#################################################"
sleep 1

## Install oh-my-zsh
if ! [ -x "$(command -v zsh)" ]; then
  h -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

## Configure XORG
Xorg :0 -configure
sudo cp $HOME/xorg.conf.new /etc/X11/xorg.conf
rm $HOME/xorg.conf.new

## copy XInitRC to home
cp ./dotfiles/.xinitrc ~/.xinitrc

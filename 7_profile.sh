#!/bin/bash

# xdg-user-dirs-update

mkdir -p $HOME/Downloads/{t_done,t_work,comics}
mkdir -p $HOME/Git
mkdir -p $HOME/Media
mkdir -p $HOME/Pictures/{Wall_use,screenshots,IMAGES_COPIED,IMAGES_SELECTED}
mkdir -p $HOME/Soft
mkdir -p $HOME/Stuff
mkdir -p $HOME/Temp
mkdir -p $HOME/.vim/undodir
sudo cp -r /home/freeman/.vim /root/
sudo mkdir -p /root/.config
sudo cp -r /home/freeman/.config/vifm /root/.config/
sudo sed -i 's/colorscheme solarized-light-256 Default-256 Default/" colorscheme solarized-light-256 Default-256 Default/' /root/.config/vifm/vifmrc 
sudo sed -i 's/" colorscheme solarized-light-256-r.vifm/colorscheme solarized-light-256-r.vifm/' /root/.config/vifm/vifmrc 
sudo mkdir -p /run/media/freeman
sudo ln -s /run/media/freeman ~/Mounted


#setup git bare dotfiles repository
function config {
   /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
config config status.showUntrackedFiles no
config config user.email "mikhail.sergiev@gmail.com"
config config user.name "Michail-Sergievsky"
# this won't work without public key uploaded to github - REPEAT later!
config remote set-url origin git@github.com:Michail-Sergievsky/dotfiles.git
config push --set-upstream origin main

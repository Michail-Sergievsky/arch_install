#!/bin/bash

# xdg-user-dirs-update

mkdir -p $HOME/Downloads/{t_done,t_work,comics}
mkdir -p $HOME/Git
# mkdir -p $HOME/NetFolders/{torrents,syl-storage} 
mkdir -p $HOME/Pictures/{Wall_use,screenshots,IMAGES_COPIED,IMAGES_SELECTED}
mkdir -p $HOME/Soft
mkdir -p $HOME/Stuff
mkdir -p $HOME/Temp
mkdir -p $HOME/.vim/undodir
sudo cp /home/freeman/.vim /root/
sudo mkdir /root/.config
sudo cp -r /home/freeman/.config/vifm /root/.config/
sudo sed -i 's/colorscheme solarized-light-256 Default-256 Default/" colorscheme solarized-light-256 Default-256 Default/' /root/.config/vifm/vifmrc 
sudo sed -i 's/" colorscheme solarized-light-256-r.vifm/colorscheme solarized-light-256-r.vifm/' /root/.config/vifm/vifmrc 
sudo mkdir -p /run/media/freeman
ln -s /run/media/freeman ~/Mounted

#!/bin/bash
# LAUNCH FROM USERNAME $HOME!!!!

. ~/.bashrc
. ~/.bash_aliases

#vim setup
vim +PlugUpgrade +PlugUpdate +helptags ALL +qall
sudo cp -r $HOME/.vim /root/
sudo mkdir -p /root/.config
#vifm setup
$HOME/.config/vifm/scripts/bash_alias_to_vifm_commands.sh
sudo cp -r $HOME/.config/vifm /root/.config/
sudo sed -i 's/colorscheme solarized-light-256 Default-256 Default/" colorscheme solarized-light-256 Default-256 Default/' /root/.config/vifm/vifmrc 
sudo sed -i 's/" colorscheme solarized-light-256-r.vifm/colorscheme solarized-light-256-r.vifm/' /root/.config/vifm/vifmrc 
#create Mounted dir for current user
sudo mkdir -p /run/media/$USER
sudo ln -s /run/media/$USER ~/Mounted

#Exclude mount point from locate DB
echo 'PRUNEPATHS = "/run/media"' | sudo tee -a /etc/updatedb.conf > /dev/null

#copy skel
sudo cp -r /arch_install/files/skel/.bash_logout /etc/skel
sudo cp -r /arch_install/files/skel/.bash_profile /etc/skel
sudo cp -r /arch_install/files/skel/.bashrc /etc/skel

# setup reflector weekly update
sudo cp -r /arch_install/files/xdg/reflector/reflector.conf /etc/xdg/reflector/

#optional copy config for UPS
sudo cp -r /arch_install/files/pwrstatd.conf /etc/

# move pacman hooks
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp -r /arch_install/files/pacman-cache-cleanup.hook /etc/pacman.d/hooks/

# generate passkey if needed
# ssh-keygen -t ed25519

#restore private stuff
chown $USER:$USER -R $HOME/Backup/Host/
find ~/Backup/Host/ -type f -exec chmod 600 '{}' \;
mkdir $HOME/.cert
mkdir $HOME/.ssh
sudo cp -rf $HOME/Backup/Host/etc/hosts /etc/
sudo cp -rf $HOME/Backup/Host/et/fstab /etc/
sudo cp -rf $HOME/Backup/Host/etc/NetworkManager/system-connections/* /etc/NetworkManager/system-connections/ 
cp -rf $HOME/Backup/Host/.ssh/* $HOME/.ssh/ 
cp -rf $HOME/Backup/Host/.cert/ $HOME/.cert/ 
cp -rf $HOME/Backup/Host/.env_priv $HOME/
sudo nmcli general reload

#copy backup_private_files unit
mkdir -p $HOME/.config/systemd/user
cp -r /arch_install/files/systemd/backup_private_files.service $HOME/.config/systemd/user/
cp -r /arch_install/files/systemd/backup_private_files.timer $HOME/.config/systemd/user/
cp -r /arch_install/files/systemd/backup_private_files.sh $HOME/.scripts/
chmod u+x $HOME/.scripts/* $HOME/.scripts/*/* 
sed -i 's/tempuser/$USER/' $HOME/.config/systemd/user/backup_private_files.service
sed -i 's/tempuser/$USER/' $HOME/.scripts/backup_private_files.sh 
systemctl enable --user --now backup_private_files.timer

# this won't work without public key uploaded to github
config remote set-url origin git@github.com:Michail-Sergievsky/dotfiles.git
config push --set-upstream origin main

usermod -aG docker $USER
usermod -aG wireshark $USER

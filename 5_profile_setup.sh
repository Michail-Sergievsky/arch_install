#!/bin/bash
# Backup must be put in $HOME/Backup/Hostname
# LAUNCH FROM USERNAME $HOME!!!!

# Check for internet connectivity
if ping -c 4 8.8.8.8 &> /dev/null; then
    echo "Continue"
else
    echo "CONNECT TO INTERNET!!!"
    exit 1
fi

# EDIT HOSTNAME
HOSTNAME=hostname

# Check if the Backup directory exists
if [ -d "$HOME/Backup/$HOSTNAME" ]; then
    echo "Continuing with the script..."
else
    echo "COPY BACKUP DIR!"
    exit 1
fi

source ~/.bashrc
source ~/.bash_aliases
#in case config won't loaded from .bash_alias
function config {
   /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}

#restore private stuff
chown $USER:$USER -R $HOME/Backup/$HOSTNAME/
find ~/Backup/$HOSTNAME/ -type f -exec chmod 600 '{}' \;
mkdir $HOME/.cert
mkdir $HOME/.ssh
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/hosts /etc/
sudo cp -rf $HOME/Backup/$HOSTNAME/root/* /root/
# sudo cp -rf $HOME/Backup/$HOSTNAME/et/fstab /etc/
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/NetworkManager/system-connections/* /etc/NetworkManager/system-connections/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/wireguard/* /etc/wireguard/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/systemd/system/*.service /etc/systemd/system/ 
cp -rf $HOME/Backup/$HOSTNAME/.ssh/* $HOME/.ssh/ 
chmod 600 $HOME/.ssh/* -R
cp -rf $HOME/Backup/$HOSTNAME/.cert/* $HOME/.cert/ 
cp -rf $HOME/Backup/$HOSTNAME/.scripts/* $HOME/.scripts/ 
cp -rf $HOME/Backup/$HOSTNAME/.config/* $HOME/.config/ 
cp -rf $HOME/Backup/$HOSTNAME/.env_priv $HOME/

sudo nmcli conn reload

#copy backup_private_files unit
mkdir -p $HOME/.config/systemd/user
sed -i 's/tempuser/'"${USER}"'/g' /arch_install/files/systemd/backup_private_files.service
sudo cp -r /arch_install/files/systemd/backup_private_files.service /etc/systemd/system/
sudo cp -r /arch_install/files/systemd/backup_private_files.timer /etc/systemd/system/
chmod u+x $HOME/.scripts/* $HOME/.scripts/*/* 
chmod u+x $HOME/.config/systemd/user/*.sh
sudo systemctl enable --now backup_private_files.timer

# final setup for bare git dotfiles, won't work without public key!
config remote set-url origin git@github.com:Michail-Sergievsky/dotfiles.git
config push --set-upstream origin main

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

# OPTIONAL COPY CONFIG FOR UPS
#sudo cp -r /arch_install/files/pwrstatd.conf /etc/

# move pacman hooks
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp -r /arch_install/files/pacman-cache-cleanup.hook /etc/pacman.d/hooks/

#GOOGLEDRIVE
rclone bisync ~/GoogleDrive gdrive: --resync
systemctl --user daemon-reload
systemctl --user enable --now rclone-sync.timer

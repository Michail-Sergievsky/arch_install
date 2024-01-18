#!/bin/bash
#Exclude mount point from locate DB
sudo echo 'PRUNEPATHS = "/run/media"' >> /etc/updatedb.conf

#copy skel
sudo cp -r /arch_install/files/skel/.bash_logout /etc/skel
sudo cp -r /arch_install/files/skel/.bash_profile /etc/skel
sudo cp -r /arch_install/files/skel/.bashrc /etc/skel

# setup reflector weekly update
sudo cp -r /arch_install/files/xdg/reflector/reflector.conf /etc/xdg/reflector/

#optional copy config for UPS
sudo cp -r files/pwrstatd.conf /etc/

#generate passkey
user=$(echo $HOME | awk -F'/' '{print $3}')
ssh-keygen -b 2048 -t rsa -f /home/"$user"/.ssh/sshkey -q -N ""

# move pacman hooks
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp -r /arch_install/files/pacman-cache-cleanup.hook /etc/pacman.d/hooks/
# add media to fstab

printf "\e[1;32m Left Firefox, thunderbird, skype, zoom, discord, telegram\e[0m"

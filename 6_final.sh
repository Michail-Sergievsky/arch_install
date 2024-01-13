#!/bin/bash
#copy skel
sudo cp -r files/skel/.bash_logout /etc/skel
sudo cp -r files/skel/.bash_profile /etc/skel
sudo cp -r files/skel/.bashrc /etc/skel

# setup reflector weekly update
cp -r files/xdg/reflector/reflector.conf /etc/xdg/reflector/

#optional copy config for UPS
cp -r files/pwrstatd.conf /etc/

#generate passkey
user=$(echo $HOME | awk -F'/' '{print $3}')
ssh-keygen -b 2048 -t rsa -f /home/"$user"/.ssh/sshkey -q -N ""

# move pacman hooks
# add media to fstab

# VIM
# PlugUpgrade
# PlugUpdate
# mkspell

#firefox
# skype, zoom, discord

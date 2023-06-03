#!/bin/bash

# GRUB
# uefi
# check efi-directory!!!!
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# mbr (GPT with BIOS)
# grub-install --target=i386-pc /dev/sdx # replace sdx with your disk name, not the partition
# grub-mkconfig -o /boot/grub/grub.cfg

#network
pacman -S networkmanager network-manager-applet dhclient

#Notebook
# pacman -S bluez bluez-utils tlp

# Video drivers
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
# pacman -S --noconfirm xf86-video-intel = NOT RECOMENDED!
# pacman -S --noconfirm mesa lib32-mesa

#network
systemctl enable NetworkManager
#notebook
systemctl enable bluetooth
systemctl enable tlp

#user - change username!!!!!!!!
useradd -m user
echo user:password | chpasswd
usermod -aG user user
echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user

printf "\e[1;32m NOW LOGOUT FROM CHROOT, reboot\e[0m"

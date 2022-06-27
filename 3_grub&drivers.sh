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
# pacman -S --noconfirm xf86-video-intel

#network
systemctl enable NetworkManager
#notebook
systemctl enable bluetooth
systemctl enable tlp

#user
useradd -m freeman
echo freeman:password | chpasswd
usermod -aG freeman freeman
echo "freeman ALL=(ALL) ALL" >> /etc/sudoers.d/freeman

printf "\e[1;32m NOW LOGOUT FROM CHROOT, reboot\e[0m"

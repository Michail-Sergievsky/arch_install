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

systemctl enable NetworkManager
#notebook
systemctl enable bluetooth
systemctl enable tlp
#for ssd
systemctl enable fstrim.timer

reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

useradd -m freeman
echo freeman:password | chpasswd
usermod -aG freeman freeman

echo "freeman ALL=(ALL) ALL" >> /etc/sudoers.d/freeman

printf "\e[1;32mYay+Polybar\e[0m"

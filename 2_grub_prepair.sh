#!/bin/bash

#update pacman
pacman -Sy

#time
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
#language
sed -i '177s/.//' /etc/locale.gen
sed -i '403s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#hostname
echo "arch" >> /etc/hostname
#hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
#root user
echo root:password | chpasswd

#uefi
pacman -S --noconfirm grub efibootmgr efivar
#mbr
# pacman -S grub

# edit /etc/default/grub
printf "\e[1;32mEDIT GRUB CONFIG!\e[0m"

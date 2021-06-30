#!/bin/bash

pacman -Sy

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
sed -i '403s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

#uefi
pacman -S grub efibootmgr efivar
#mbr
# pacman -S grub

# edit /etc/default/grub
printf "\e[1;32mEDIT GRUB CONFIG!\e[0m"
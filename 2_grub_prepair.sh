#!/bin/bash
#time
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc
#language
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#hostname - CHANGE when installing!
HOST=hostname
echo "${HOST}" >> /etc/hostname
#hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 "${HOST}".localdomain "${HOST}"" >> /etc/hosts
# root user - TEST openssl
usermod --password $(openssl passwd password) root
# TEST!!! not work under user (in arch)
# echo root:password | chpasswd

#update pacman
sudo pacman -Sy
#uefi
sudo pacman -S --noconfirm grub efibootmgr efivar
#mbr
# pacman -S grub

# edit /etc/default/grub
printf "\e[1;32mEDIT GRUB CONFIG!\e[0m"

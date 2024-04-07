#!/bin/bash
#Pacman
#enable 32-bit apps
sed -i 's:^#\[multilib\]$:\[multilib\]:' /etc/pacman.conf 
sed -i '' -e '/^\[multilib\]$/ {' -e 'n; s/.*/Include = \/etc\/pacman.d\/mirrorlist/' -e '}' /etc/pacman.conf 
#enable parallel downloads
sed -i 's:#ParallelDownloads:ParallelDownloads:' /etc/pacman.conf

#Swapfile
touch /swapfile
#<<<change size>>>
dd if=/dev/zero of=/swapfile bs=1G count=16 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "#swapfile" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

#time
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

#language
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

#<<<change hostname>>>
HOST=hostname
echo "${HOST}" >> /etc/hostname
#hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 "${HOST}".localdomain "${HOST}"" >> /etc/hosts
# <<<change root pass>>>
usermod --password $(openssl passwd password) root

#update pacman
sudo pacman -Sy
#uefi
sudo pacman -S --noconfirm grub efibootmgr efivar
#mbr
# pacman -S grub

# edit /etc/default/grub - TEST MORE!!!
# sed -i 's:^GRUB_TIMEOUT=.:GRUB_TIMEOUT=2:' /etc/default/grub
# sed -i 's:^GRUB_CMDLINE_LINUX_DEFAULT="loglevel=.":GRUB_CMDLINE_LINUX_DEFAULT="loglevel=7":' /etc/default/grub

printf "\e[1;32m CHECK pacman.conf & edit /etc/default/grub!!!\e[0m"

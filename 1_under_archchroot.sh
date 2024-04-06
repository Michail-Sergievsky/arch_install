#!/bin/bash
#Pacman
#enable 32-bit apps
sed -i 's:^#\[multilib\]$:\[multilib\]:' /etc/pacman.conf 
sed -i '' -e '/^\[multilib\]$/ {' -e 'n; s/.*/Include = \/etc\/pacman.d\/mirrorlist/' -e '}' /etc/pacman.conf 
#enable parallel downloads
sed -i 's:#ParallelDownloads:ParallelDownloads:' /etc/pacman.conf
less /etc/pacman.conf

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
# root user - TEST openssl
usermod --password $(openssl passwd password) root

#update pacman
sudo pacman -Sy
#uefi
sudo pacman -S --noconfirm grub efibootmgr efivar
#mbr
# pacman -S grub

# edit /etc/default/grub
sed -i 's:^GRUB_TIMEOUT=.:GRUB_TIMEOUT=2:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX_DEFAULT="loglevel=.":GRUB_CMDLINE_LINUX_DEFAULT="loglevel=7":' /etc/default/grub
less /etc/default/grub

# GRUB
# uefi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# mbr (GPT with BIOS)
# grub-install --target=i386-pc /dev/sdx # replace sdx with your disk name, not the partition
# grub-mkconfig -o /boot/grub/grub.cfg

#network
pacman -S networkmanager network-manager-applet dhclient

#Notebook
# pacman -S bluez bluez-utils tlp

# VIDEO DRIVERS
# ATI
# moder ati
# pacman -S --noconfirm xf86-video-amdgpu
# old ati
# pacman -S --noconfirm xf86-video-ati
# OpenGL
# pacman -S --noconfirm mesa lib32-mesa
# Vulkan
# pacman -S --noconfirm vulkan-radeon lib32-vulkan-radeon 

# NVIDA
# nvida proprietary
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
# nvida open source
# pacman -S --noconfirm xf86-video-nouveau mesa lib32-mesa

# INTEL
# pacman -S --noconfirm xf86-video-intel = NOT RECOMENDED!
# insted just install this
# pacman -S --noconfirm mesa lib32-mesa
# pacman -S --noconfirm vulkan-intal lib32-vulkan-intel

#network
systemctl enable NetworkManager
#notebook
#systemctl enable bluetooth
#systemctl enable tlp

#<<<change username>>>
USER=username
GROUP="${USER}"
PASSWORD="${USER}"
useradd -m -s /bin/bash "${USER}"
# echo "${USER}":password | chpasswd
# test if archiso have opensss!
usermod --password $(openssl passwd "${PASSWORD}") "${USER}"
usermod -aG "${GROUP}" "${USER}"
echo "%${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}"
chown -R $USER:$USER /arch_install

printf "\e[1;32m NOW LOGOUT FROM CHROOT, reboot and continue as USER\e[0m"


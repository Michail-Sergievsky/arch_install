#!/bin/bash

# GRUB
# uefi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# mbr (GPT with BIOS)
# grub-install --target=i386-pc /dev/sdx # replace sdx with your disk name, not the partition
# grub-mkconfig -o /boot/grub/grub.cfg

#network
pacman -S --noconfirm networkmanager network-manager-applet dhclient

#Notebook
# pacman -S --noconfirm bluez bluez-utils tlp

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

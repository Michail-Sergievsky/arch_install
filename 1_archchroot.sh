#!/bin/bash

# === ARCH SETUP PHASE 1 ===
echo "==> Enabling multilib and parallel downloads in pacman.conf..."
sed -i 's:^#\[multilib\]$:\[multilib\]:' /etc/pacman.conf 
sed -i '' -e '/^\[multilib\]$/ {' -e 'n; s/.*/Include = \/etc\/pacman.d\/mirrorlist/' -e '}' /etc/pacman.conf 
sed -i 's:#ParallelDownloads:ParallelDownloads:' /etc/pacman.conf

echo "==> Creating swapfile..."
touch /swapfile
#<<<change size>>>
dd if=/dev/zero of=/swapfile bs=1G count=16 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "#swapfile" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

echo "==> Setting timezone and hardware clock..."
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo "==> Generating locales..."
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "==> Configuring hostname and hosts..."
read -p "Enter hostname: " HOST
echo "Using hostname: $HOST"
echo "${HOST}" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ${HOST}.localdomain ${HOST}" >> /etc/hosts

echo "==> Setting root password..."
usermod --password $(openssl passwd password) root

echo "==> Updating package database and installing GRUB..."
sudo pacman -Sy
sudo pacman -S --noconfirm grub efibootmgr efivar
# MBR: pacman -S grub


echo "==> Configuring GRUB defaults..."
sed -i 's:^GRUB_TIMEOUT=.:GRUB_TIMEOUT=0:' /etc/default/grub
sed -i 's:^GRUB_CMDLINE_LINUX_DEFAULT="loglevel=.*":GRUB_CMDLINE_LINUX_DEFAULT="loglevel=7":' /etc/default/grub

echo -e "\e[1;32m CHECK pacman.conf & edit /etc/default/grub!!!\e[0m"

echo "==> Installing GRUB bootloader..."
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
# MBR (GPT with BIOS):
# grub-install --target=i386-pc /dev/sdx
# grub-mkconfig -o /boot/grub/grub.cfg

echo "==> Installing NetworkManager and enabling service..."
pacman -S --noconfirm networkmanager network-manager-applet dhclient
systemctl enable NetworkManager

if ls /sys/class/power_supply/BAT* &>/dev/null; then
  echo "Notebook detected: installing bluez, bluez-utils, and tlp"
  pacman -S --noconfirm bluez bluez-utils tlp
  systemctl enable bluetooth
  systemctl enable tlp
else
  echo "Desktop detected: skipping notebook packages"
fi

echo "==> Detecting and installing GPU drivers..."
GPU_VENDOR=$(lspci | grep -E "VGA|3D" | awk '{print tolower($0)}')

if echo "$GPU_VENDOR" | grep -q "nvidia"; then
  echo "NVIDIA GPU detected: installing proprietary driver"
  pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
elif echo "$GPU_VENDOR" | grep -q "amd"; then
  echo "AMD GPU detected: installing mesa and vulkan-radeon"
  pacman -S --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
elif echo "$GPU_VENDOR" | grep -q "intel"; then
  echo "Intel GPU detected: installing mesa and vulkan-intel"
  pacman -S --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel
else
  echo "Unknown GPU vendor: manual setup might be needed"
fi

#<<<change username>>>
echo "==> Creating user account..."
read -p "Enter username: " USER
echo "Using username: $USER"
GROUP="${USER}"
PASSWORD="${USER}"
useradd -m -s /bin/bash "${USER}"
usermod --password $(openssl passwd "${PASSWORD}") "${USER}"
usermod -aG "${GROUP}" "${USER}"
echo "%${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}"
chown -R $USER:$USER /arch_install

echo -e "\e[1;32m NOW LOGOUT FROM CHROOT, reboot and continue as USER\e[0m"

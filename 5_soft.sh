#!/bin/bash

sudo pacman -S --needed reflector 
reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

#for system
sudo pacman -S --needed alsa-utils arandr atool avahi bash-completion cifs-utils cmake cups dhcpcd fd feh flameshot fzf gvim htop i3-wm i3blocks i3lock i3status jq lib32-alsa-plugins lib32-libpulse libqalculate lsscsi lxqt-policykit man-pages neofetch noto-fonts-emoji ntfs-3g openvpn pacman-contrib papirus-icon-theme parted pavucontrol picom pkgfile pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip redshift rofi rsync rxvt-unicode rxvt-unicode-terminfo sbxkb speedtest-cli task telegram-desktop timew tldr tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unzip urxvt-perls vifm w3m wget wireguard-tools xclip xdg-user-dirs xorg-apps xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop zip networkmanager-pptp networkmanager-openvpn networkmanager-openconnect networkmanager-l2tp network-manager-sstp rpm-tools nfs-utils tcpdump lsof cronie firefox

#for CD-DVDROM
sudo pacman -S --needed cdrtools dvd+rw-tools ccd2iso

# for ssd
sudo pacman -S --needed util-linux

# for ntfs filesystem
sudo pacman -S --needed ntfs-3g

# system yay
yay -S --needed dumptorrent hibernator ly nerd-fonts-source-code-pro rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs ttf-ms-fonts ttf-weather-icons update-grub urxvt-resize-font-git

# soft pacman
sudo pacman -S --needed aegisub cmus discord exiv2 flatpak ffmpeg foliate hunspell-en_us hyphen-en jre8-openjdk lhasa libreoffice-fresh libreoffice-fresh-ru mediainfo mediainfo-gui mkvtoolnix-gui mp3info mupdf-tools opusfile p7zip pinta qbittorrent soundconverter sxiv vlc zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps 

pip install ffmpeg-normalize

#soft yay
yay -S --needed freac dropbox hunspell-ru hyphen-ru libreoffice-extension-languagetool transgui-gtk zoom anki goldendict-git mcomix downgrade

# soft work
sudo pacman -S --needed remmina vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch thunderbird docker
yay -S --needed google-chrome rocketchat-client-bin icaclient visual-studio-code-bin

mkdir -p $HOME/.ICAClient/cache
cp /opt/Citrix/ICAClient/config/{All_Regions,Trusted_Region,Unknown_Region,canonicalization,regions}.ini $HOME/.ICAClient/

sudo downgrade wireshark-cli
sudo downgrade wireshark-qt 

# CyberPower UPS daemon
yay -S --needed powerpanel

sudo pkgfile -u

systemctl --user enable greenclip.service
sudo systemctl enable cups.service
sudo systemctl enable sshd
sudo systemctl enable avahi-daemon
sudo systemctl enable reflector.timer
sudo systemctl enable reflector.service
sudo systemctl enable pkgfile-update.timer
sudo systemctl enable ly.service
sudo timedatectl set-ntp true
#for ssd
sudo systemctl enable fstrim.service
sudo systemctl enable fstrim.timer
#CyberPower UPS
sudo systemctl enable pwrstatd

printf "\e[1;32mNow dotfiles\e[0m"

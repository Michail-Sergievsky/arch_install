#!/bin/bash

sudo pacman -S reflector 
reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

#for system
sudo pacman -S alsa-utils arandr atool avahi bash-completion cifs-utils cmake cups dhcpcd fd feh flameshot fzf gvim htop i3-wm i3blocks i3lock i3status jq lib32-alsa-plugins lib32-libpulse libqalculate lsscsi lxqt-policykit man-pages neofetch noto-fonts-emoji ntfs-3g pacman-contrib papirus-icon-theme parted picom pkgfile pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip redshift rofi rsync rxvt-unicode rxvt-unicode-terminfo sbxkb speedtest-cli task telegram-desktop timew tldr tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unzip urxvt-perls vifm w3m wget xclip xdg-user-dirs xorg-apps xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop zip

#for CD-DVDROM
sudo pacman -S cdrtools dvd+rw-tools ccd2iso

# for ssd
sudo pacman -S util-linux

# for ntfs filesystem
sudo pacman -S ntfs-3g

# soft pacman
sudo pacman -S aegisub anki cmus discord exiv2 flatpak foliate goldendict hunspell-en_us hyphen-en jre8-openjdk lhasa libreoffice-fresh libreoffice-fresh-ru mcomix mediainfo mediainfo-gui mkvtoolnix-gui mp3info mupdf-tools opusfile p7zip pinta qbittorrent soundconverter sxiv vlc zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps 

pip install tasklib

# system
yay -S dumptorrent hibernator ly nerd-fonts-source-code-pro rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs ttf-ms-fonts ttf-weather-icons update-grub urxvt-resize-font-git

#soft yay
yay -S freac hunspell-ru hyphen-ru libreoffice-extension-languagetool skypeforlinux-stable-bin transgui-gtk zoom

# CyberPower UPS daemon
yay -S powerpanel

sudo pkgfile -u

sudo systemctl enable cups.service
sudo systemctl enable sshd
sudo systemctl enable avahi-daemon
sudo systemctl enable reflector.timer
sudo systemctl enable reflector.service
sudo systemctl enable pkgfile-update.timer
sudo systemctl --user enable greenclip.service
sudo systemctl enable ly.service
#for ssd
sudo systemctl enable fstrim.service
sudo systemctl enable fstrim.timer
#CyberPower UPS
sudo systemctl enable pwrstatd

printf "\e[1;32mNow dotfiles\e[0m"

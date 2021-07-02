#!/bin/bash

sudo pacman -S reflector 
reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

#for system
sudo pacman -S --needed  xorg-server xorg-docs xorg-apps xorg-xinit rxvt-unicode urxvt-perls rxvt-unicode-terminfo pkgfile i3-wm i3-wm i3lock i3status i3blocks arandr feh sbxkb ttf-droid noto-fonts-emoji ttf-liberation gvim jq python-pip task timew picom rofi vifm atool alsa-utils pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer lib32-libpulse lib32-alsa-plugins udisks2 udiskie fzf fd flameshot speedtest-cli sbxkb xorg-setxkbmap telegram-desktop lxqt-policykit papirus-icon-theme libqalculate cifs-utils cmake htop ntfs-3g redshift tree ueberzug wget xclip bash-completion dhcpcd lsscsi man-pages tldr w3m avahi xorg-xprop neofetch pacman-contrib xdg-user-dirs rsync cups zip parted unzip

#for CD-DVDROM
sudo pacman -S --needed cdrtools dvd+rw-tools ccd2iso

# for ssd
sudo pacman -S util-linux

# for ntfs filesystem
sudo pacman -S ntfs-3g

# soft pacman
sudo pacman -S --needed zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps cmus opusfile foliate libreoffice-fresh libreoffice-fresh-ru hunspell-en_us hyphen-en vlc anki firefox flatpak mediainfo mediainfo-gui mkvtoolnix-gui mp3info pinta qbittorrent soundconverter sxiv exiv2 discord goldendict jre8-openjdk aegisub mcomix mupdf-tools unrar p7zip lhasa

pip install tasklib

# system
yay -S urxvt-resize-font-git nerd-fonts-source-code-pro siji-git ttf-weather-icons ttf-ms-fonts ly rofi-dmenu rofi-blezz rofi-greenclip simple-mtpfs dumptorrent hibernator update-grub

#soft yay
yay -S zoom skypeforlinux-stable-bin transgui-gtk zoom hunspell-ru hyphen-ru libreoffice-extension-languagetool freac

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

#!/bin/bash
#LAUNCH FROM ARCH_INSTALL! not use /

# Check for internet connectivity
if ping -c 4 8.8.8.8 &> /dev/null; then
    echo "Continue"
else
    echo "CONNECT TO INTERNET!!!"
    exit 1
fi

# Wifi with iwctl
# iwctl
# device list
# station wlan0 scan 
# station wlan0 get-networks 
# station wlan0 connect YOUR-NETWORK-NAME
#     enter wifi password
# exit

# connect to wifi with nmcli
# nmcli device wifi list
# nmcli device wifi connect SSID_or_BSSID password password

echo "==> updating pacman"
sudo pacman -Sy

echo "==> Installing and configuring reflector..."
sudo pacman -S --noconfirm reflector rsync
sudo reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

echo "==> Installing pacman packages for desktop_essentials"
for pkg in adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts alsa-utils android-file-transfer arandr atool avahi bash-completion bc bind cifs-utils cmake cmus cronie cups dhcpcd dmidecode exiv2 f3d fd feh ffmpeg firefox flameshot fzf gnupg gvim htop i3-wm i3blocks i3lock i3status imagemagick inetutils iotop jq jre8-openjdk lhasa lib32-alsa-plugins lib32-libpulse libfaketime libqalculate lsof lsscsi lxqt-policykit ly man-pages mediainfo mediainfo-gui mkvtoolnix-gui mp3info mpv mtr mupdf-tools neofetch net-tools network-manager-applet network-manager-sstp networkmanager-l2tp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nfs-utils noto-fonts-emoji ntfs-3g openresolv openssh openvpn opusfile otf-ipaexfont otf-ipafont 7zip pacman-contrib papirus-icon-theme parted pass pavucontrol pdfgrep pdfslicer picom pkgfile plocate polybar poppler powerline-fonts pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip python-tasklib qbittorrent qrencode rclone redshift ripgrep rofi rofi-pass rpm-tools rsync rxvt-unicode rxvt-unicode-terminfo sbxkb shellcheck speedtest-cli sshfs strace sxiv task tcpdump telegram-desktop termdown timew tldr tmux traceroute tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unrar unzip urxvt-perls util-linux vifm w3m wget wireguard-tools xclip xdg-user-dirs xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop yt-dlp zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip iw sshpass; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_desktop_essentials-pacman-notfound.txt
    fi
done

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "==> Installing yay packages for desktop_essentials"
for pkg in downgrade dropbox dumptorrent epub-thumbnailer-git fontpreview icons-in-terminal-git mcomix nerd-fonts-sf-mono nerd-fonts-source-code-pro pacman-cleanup-hook polybar rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs taskopen transgui-gtk ttf-weather-icons update-grub urxvt-resize-font-git; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        yay -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_desktop_essentials-yay-notfound.txt
    fi
done

# CUSTOME PACKAGES
# for CD-DVDROM
# sudo pacman -S --noconfirm cdrtools dvd+rw-tools ccd2iso

# CyberPower UPS daemon
# yay -S powerpanel

sudo pkgfile -u

echo "==> Enabling related systemd services..."

sudo systemctl enable --now cups.service
sudo systemctl enable --now sshd
sudo systemctl enable --now avahi-daemon
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now reflector.service
sudo systemctl enable --now pkgfile-update.timer
sudo systemctl enable --now plocate-updatedb.timer 

# For SSDs
sudo systemctl enable --now fstrim.service
sudo systemctl enable --now fstrim.timer

# Display manager
sudo systemctl enable ly.service

#CyberPower UPS
# sudo systemctl enable --now pwrstatd

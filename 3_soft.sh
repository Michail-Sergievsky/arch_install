#!/bin/bash
#LAUNCH FROM ARCH_INSTALL! not use /

# Check for internet connectivity
if ping -c 4 8.8.8.8 &> /dev/null; then
    echo "Continue"
else
    echo "CONNECT TO INTERNET!!!"
    exit 1
fi

# connect to wifi with nmcli
# nmcli device wifi list
# nmcli device wifi connect SSID_or_BSSID password password

#update pacman
sudo pacman -Sy

#reflector
sudo pacman -S reflector 
sudo reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist
# echo $(grep "pacman soft" 5_soft.sh -A1 | tail -1)
# Choose with digits, NOT press enter!
# pacman soft
sudo pacman -S aegisub alsa-utils android-file-transfer arandr atool avahi bash-completion bc bind cifs-utils cmake cmus cronie cups dhcpcd discord exiv2 fd feh ffmpeg firefox flameshot foliate fzf gnupg gvim htop hunspell-en_us hyphen-en i3-wm i3blocks i3lock i3status imagemagick inetutils iotop jq jre8-openjdk languagetool lhasa lib32-alsa-plugins lib32-libpulse libfaketime libqalculate libreoffice-fresh libreoffice-fresh-ru lsof lsscsi lxqt-policykit man-pages mediainfo mediainfo-gui mkvtoolnix-gui mp3info mtr mupdf-tools neofetch net-tools network-manager-applet network-manager-sstp networkmanager-l2tp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nfs-utils ntfs-3g openresolv openvpn opusfile p7zip pacman-contrib papirus-icon-theme parted pass pavucontrol pdfgrep pdfslicer picom pinta pkgfile plocate poppler pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip python-pip qbittorrent qrencode redshift ripgrep rofi rofi-pass rpm-tools rsync rxvt-unicode rxvt-unicode-terminfo sbxkb shellcheck speedtest-cli strace sxiv task tcpdump telegram-desktop termdown tesseract tesseract-data-eng tesseract-data-rus thunderbird timew tldr tmux traceroute tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unrar unzip urxvt-perls util-linux vifm vlc w3m wget wireguard-tools xclip xdg-user-dirs xorg-apps xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip sshfs 
#install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# yay soft
yay -S anki downgrade drawio-desktop dropbox dumptorrent epub-thumbnailer-git fontpreview freac goldendict-ng google-chrome hibernator hunspell-ru hyphen-ru i3-gnome-pomodoro-git icons-in-terminal-git libreoffice-extension-languagetool ly mcomix nerd-fonts-source-code-pro networkmanager-fortisslvpn pacman-cleanup-hook polybar rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs transgui-gtk ttf-ms-fonts ttf-weather-icons update-grub urxvt-resize-font-git zoom wps-office ttf-wps-fonts wps-office-all-dicts-win-languages 

#fonts
sudo pacman -S adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts otf-ipafont otf-ipaexfont otf-ipaexfont noto-fonts-emoji powerline-fonts
yay -S nerd-fonts-sf-mono ttf-ms-fonts ttf-weather-icons 

#python packages install
pipx install ffmpeg-normalize shell-gpt llm

#flacon for converting flac to opus
yay -S flacon
sudo pacman -S sox opus-tools mac

# for CD-DVDROM
# sudo pacman -S cdrtools dvd+rw-tools ccd2iso

#soft mediawork
sudo pacman -S handbrake obs-studio kdenlive audacity gimp gimagereader-gtk

# soft work
sudo pacman -S vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch docker ansible wireshark-cli wireshark-qt freerdp virt-manager python-psycopg2
yay -S kesl kesl-gui remmina rocketchat-client-bin
# yay -S visual-studio-code-bin

# CyberPower UPS daemon
yay -S powerpanel

sudo pkgfile -u

sudo systemctl enable --now cups.service
sudo systemctl enable --now sshd
sudo systemctl enable --now avahi-daemon
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now reflector.service
sudo systemctl enable --now pkgfile-update.timer
sudo systemctl enable --now plocate-updatedb.timer 
sudo timedatectl set-ntp true
#for ssd
sudo systemctl enable --now fstrim.service
sudo systemctl enable --now fstrim.timer
sudo systemctl enable ly.service
#CyberPower UPS
# sudo systemctl enable --now pwrstatd

printf "\e[1;32mNow profile\e[0m"

#!/bin/bash

# Check for internet connectivity
if ping -c 4 8.8.8.8 &> /dev/null; then
    echo "Continue"
else
    echo "CONNECT TO INTERNET!!!"
    exit 1
fi

#update pacman
sudo pacman -Sy

#reflector
sudo pacman -S --needed reflector 
sudo reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist
# echo $(grep "pacman soft" 5_soft.sh -A1 | tail -1)
# pacman soft
sudo pacman -S --needed alsa-utils arandr atool avahi bash-completion cifs-utils cmake cups dhcpcd fd feh flameshot fzf gvim htop i3-wm i3blocks i3lock i3status jq lib32-alsa-plugins lib32-libpulse libqalculate lsscsi lxqt-policykit man-pages neofetch ntfs-3g openvpn pacman-contrib papirus-icon-theme parted pavucontrol picom pkgfile pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip redshift rofi rsync rxvt-unicode rxvt-unicode-terminfo sbxkb speedtest-cli task telegram-desktop timew tldr tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unzip urxvt-perls vifm w3m wget wireguard-tools xclip xdg-user-dirs xorg-apps xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop zip networkmanager-pptp networkmanager-openvpn networkmanager-openconnect networkmanager-l2tp network-manager-sstp network-manager-applet rpm-tools nfs-utils tcpdump lsof cronie firefox languagetool pdfslicer libfaketime pdfgrep util-linux termdown bind thunderbird aegisub cmus discord exiv2 ffmpeg foliate hunspell-en_us hyphen-en jre8-openjdk lhasa libreoffice-fresh libreoffice-fresh-ru mediainfo mediainfo-gui mkvtoolnix-gui mp3info mupdf-tools opusfile p7zip pinta qbittorrent sxiv vlc zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps qrencode traceroute openresolv mtr  inetutils android-file-transfer unrar bc strace net-tools shellcheck plocate ripgrep imagemagick poppler python-pip tesseract tesseract-data-eng tesseract-data-rus iotop pass gnupg rofi-pass tmux

#install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# yay soft
yay -S --needed polybar dumptorrent hibernator ly nerd-fonts-source-code-pro rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs ttf-ms-fonts ttf-weather-icons update-grub urxvt-resize-font-git freac dropbox hunspell-ru hyphen-ru libreoffice-extension-languagetool transgui-gtk zoom anki goldendict-ng mcomix downgrade pacman-cleanup-hook icons-in-terminal-git epub-thumbnailer-git fontpreview i3-gnome-pomodoro-git google-chrome networkmanager-fortisslvpn

#fonts
sudo pacman -S --needed adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts otf-ipafont otf-ipaexfont otf-ipaexfont noto-fonts-emoji powerline-fonts
yay -S --needed nerd-fonts-sf-mono ttf-ms-fonts ttf-weather-icons 

#python packages install
pipx install ffmpeg-normalize shell-gpt llm

#flacon for converting flac to opus
yay -S --needed flacon
sudo pacman -S --needed sox opus-tools mac

# for CD-DVDROM
# sudo pacman -S --needed cdrtools dvd+rw-tools ccd2iso

#soft mediawork
sudo pacman -S --needed handbrake obs-studio kdenlive audacity gimp gimagereader-gtk

# soft work
sudo pacman -S --needed vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch docker ansible wireshark-cli wireshark-qt
yay -S --needed kesl kesl-gui remmina rocketchat-client-bin
# yay -S --needed visual-studio-code-bin

# CyberPower UPS daemon
yay -S --needed powerpanel

sudo pkgfile -u

systemctl --user enable --now greenclip.service
sudo systemctl enable --now cups.service
sudo systemctl enable --now sshd
sudo systemctl enable --now avahi-daemon
sudo systemctl enable --now reflector.timer
sudo systemctl enable --now reflector.service
sudo systemctl enable --now pkgfile-update.timer
sudo systemctl enable --now ly.service
sudo systemctl enable --now plocate-updatedb.timer 
sudo timedatectl set-ntp true
#for ssd
sudo systemctl enable --now fstrim.service
sudo systemctl enable --now fstrim.timer
#CyberPower UPS
# sudo systemctl enable --now pwrstatd

printf "\e[1;32mNow profile\e[0m"

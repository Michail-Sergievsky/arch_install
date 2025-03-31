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

# update pacman
sudo pacman -Sy

# reflector
sudo pacman -S --noconfirm reflector 
sudo reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

# pacman soft home
pacman_home_pkgs=(
    aegisub alsa-utils android-file-transfer arandr atool avahi bash-completion bc bind cifs-utils cmake cmus cronie cups dhcpcd discord exiv2 fd feh ffmpeg
    firefox flameshot foliate fzf gnupg gvim htop hunspell-en_us hyphen-en i3-wm i3blocks i3lock i3status imagemagick inetutils iotop jq jre8-openjdk
    languagetool lhasa lib32-alsa-plugins lib32-libpulse libfaketime libqalculate libreoffice-fresh libreoffice-fresh-ru lsof lsscsi lxqt-policykit man-pages
    mediainfo mediainfo-gui mkvtoolnix-gui mp3info mtr mupdf-tools neofetch net-tools network-manager-applet network-manager-sstp networkmanager-l2tp
    networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nfs-utils ntfs-3g openresolv openvpn opusfile p7zip pacman-contrib
    papirus-icon-theme parted pass pavucontrol pdfgrep pdfslicer picom pinta pkgfile plocate poppler pulseaudio pulseaudio-alsa pulseaudio-equalizer
    pulseaudio-jack pulsemixer python-pip python-pip qbittorrent qrencode redshift ripgrep rofi rofi-pass rpm-tools rsync rxvt-unicode rxvt-unicode-terminfo
    sbxkb shellcheck speedtest-cli strace sxiv task tcpdump telegram-desktop termdown tesseract tesseract-data-eng tesseract-data-rus thunderbird timew
    tldr tmux traceroute tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unrar unzip urxvt-perls util-linux vifm vlc w3m wget wireguard-tools xclip
    xdg-user-dirs xorg-apps xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip
    sshfs yt-dlp f3d dmidecode rclone task python-tasklib handbrake obs-studio kdenlive audacity gimp gimagereader-gtk
    adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts otf-ipafont otf-ipaexfont otf-ipaexfont noto-fonts-emoji powerline-fonts
)

found_pacman_home=()
notfound_pacman_home=()

for pkg in "${pacman_home_pkgs[@]}"; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        found_pacman_home+=("$pkg")
    else
        notfound_pacman_home+=("$pkg")
    fi
done

echo "Not found pacman home packages: ${notfound_pacman_home[@]}" > pacman-home-notfound.txt
sudo pacman -S --noconfirm --needed "${found_pacman_home[@]}"

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# yay soft home
yay_home_pkgs=(
    anki downgrade drawio-desktop dropbox dumptorrent epub-thumbnailer-git fontpreview freac goldendict-ng google-chrome hibernator hunspell-ru hyphen-ru
    i3-gnome-pomodoro-git icons-in-terminal-git libreoffice-extension-languagetool ly mcomix nerd-fonts-source-code-pro networkmanager-fortisslvpn
    pacman-cleanup-hook polybar rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs transgui-gtk ttf-ms-fonts ttf-weather-icons update-grub
    urxvt-resize-font-git zoom wps-office ttf-wps-fonts wps-office-all-dicts-win-languages taskopen nerd-fonts-sf-mono ttf-ms-fonts ttf-weather-icons
    shell-gpt ffmpeg-normalize llm
)

found_yay_home=()
notfound_yay_home=()

for pkg in "${yay_home_pkgs[@]}"; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        found_yay_home+=("$pkg")
    else
        notfound_yay_home+=("$pkg")
    fi
done

echo "Not found yay home packages: ${notfound_yay_home[@]}" > yay-home-notfound.txt
yay -S --noconfirm --needed "${found_yay_home[@]}"

# pacman soft work 
pacman_work_pkgs=(vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch docker docker-compose ansible wireshark-cli wireshark-qt freerdp virt-manager python-psycopg2)

found_pacman_work=()
notfound_pacman_work=()

for pkg in "${pacman_work_pkgs[@]}"; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        found_pacman_work+=("$pkg")
    else
        notfound_pacman_work+=("$pkg")
    fi
done

echo "Not found pacman work packages: ${notfound_pacman_work[@]}" > pacman-work-notfound.txt
sudo pacman -S --noconfirm --needed "${found_pacman_work[@]}"

# yay soft work
yay_work_pkgs=(kesl kesl-gui remmina rocketchat-client-bin)

found_yay_work=()
notfound_yay_work=()

for pkg in "${yay_work_pkgs[@]}"; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        found_yay_work+=("$pkg")
    else
        notfound_yay_work+=("$pkg")
    fi
done

echo "Not found yay work packages: ${notfound_yay_work[@]}" > yay-work-notfound.txt
yay -S --noconfirm --needed "${found_yay_work[@]}"

# CUSTOME PACKAGES
# for CD-DVDROM
# sudo pacman -S --noconfirm cdrtools dvd+rw-tools ccd2iso

# flacon for converting flac to opus
# yay -S flacon
# sudo pacman -S --noconfirm sox opus-tools mac

# CyberPower UPS daemon
# yay -S powerpanel

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

#!/bin/bash
# === ARCH SETUP PHASE 2 - first boot as new user  ===
echo "==> Checking script is launched from home directory..."
if [ "$PWD" != "$HOME" ]; then
    echo "This script must be run from your home directory ($HOME). Exiting."
    exit 1
fi

echo "==> Checking internet connection..."
if ping -c 4 8.8.8.8 &> /dev/null; then
    echo "==> Internet connection: OK"
else
    echo -e "\e[1;31m==> CONNECT TO INTERNET FIRST!\e[0m"
    echo "==> Use 'iwctl' or 'nmcli' to connect to Wi-Fi"
    exit 1
fi

echo "==> Checking for backup directory..."
if [ -d "$HOME/Backup/$HOSTNAME" ]; then
    echo "==> Backup directory found. Continuing."
else
    echo -e "\e[1;31m==> BACKUP DIRECTORY MISSING!\e[0m"
    exit 1
fi

echo "==> Updating pacman..."
sudo pacman -Sy

echo "==> Installing reflector and syncing mirrors..."
sudo pacman -S --noconfirm reflector rsync
sudo reflector -c Russia -a 7 --sort rate --save /etc/pacman.d/mirrorlist

echo "==> Installing pacman packages for desktop_essentials"
for pkg in adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts alsa-utils android-file-transfer arandr atool avahi bash-completion bc bind cifs-utils cmake cmus cronie cups dhcpcd dmidecode exiv2 f3d fd feh ffmpeg firefox flameshot fzf gnupg gvim htop i3-wm i3blocks i3lock i3status imagemagick inetutils iotop jq jre8-openjdk lhasa lib32-alsa-plugins lib32-libpulse libfaketime libqalculate lsof lsscsi lxqt-policykit ly man-pages mediainfo mediainfo-gui mkvtoolnix-gui mp3info mpv mtr mupdf-tools neofetch net-tools network-manager-applet network-manager-sstp networkmanager-l2tp networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nfs-utils noto-fonts-emoji ntfs-3g openresolv openssh openvpn opusfile otf-ipaexfont otf-ipafont 7zip pacman-contrib papirus-icon-theme parted pass pavucontrol pdfgrep pdfslicer picom pkgfile plocate polybar poppler powerline-fonts pulseaudio pulseaudio-alsa pulseaudio-equalizer pulseaudio-jack pulsemixer python-pip python-tasklib qbittorrent qrencode rclone redshift ripgrep rofi rofi-pass rpm-tools rsync rxvt-unicode rxvt-unicode-terminfo sbxkb shellcheck speedtest-cli sshfs strace sxiv task tcpdump telegram-desktop termdown timew tldr tmux traceroute tree ttf-droid ttf-liberation udiskie udisks2 ueberzug unrar unzip urxvt-perls util-linux vifm w3m wget wireguard-tools xclip xdg-user-dirs xorg-docs xorg-server xorg-setxkbmap xorg-xinit xorg-xprop yt-dlp zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip iw sshpass xfsprogs ipcalc; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_desktop_essentials-pacman-notfound.txt
    fi
done

echo "==> Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "==> Installing desktop essentials from AUR with yay..."
for pkg in downgrade dropbox dumptorrent epub-thumbnailer-git fontpreview icons-in-terminal-git mcomix nerd-fonts-sf-mono nerd-fonts-source-code-pro pacman-cleanup-hook polybar rofi-blezz rofi-dmenu rofi-greenclip siji-git simple-mtpfs taskopen transgui-gtk ttf-weather-icons update-grub urxvt-resize-font-git; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        yay -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_desktop_essentials-yay-notfound.txt
    fi
done

sudo pkgfile -u

echo "==> Enabling essential systemd services..."
sudo systemctl enable --now cups.service sshd avahi-daemon reflector.timer reflector.service pkgfile-update.timer plocate-updatedb.timer fstrim.service fstrim.timer 
sudo systemclt enable ly.service

echo "==> Cleaning home directory and restoring dotfiles..."
shopt -s dotglob
for item in "$HOME"/* "$HOME"/.*; do
  [[ "$item" == "$HOME" || "$item" == "$HOME/." || "$item" == "$HOME/.." || "$item" == "$HOME/Backup" ]] && continue
  rm -rf -- "$item"
done

git clone --bare https://github.com/Michail-Sergievsky/dotfiles.git $HOME/.myconf
function config {
   /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
config checkout
config config status.showUntrackedFiles no
config config user.email "mikhail.sergiev@gmail.com"
config config user.name "Michail-Sergievsky"

echo "==> Creating user directories..."
mkdir -p $HOME/Downloads/{t_done,t_work,comics}
mkdir -p $HOME/Dropbox
mkdir -p $HOME/GoogleDrive
mkdir -p $HOME/Media
mkdir -p $HOME/Pictures/{Wall_use,screenshots,IMAGES_COPIED,IMAGES_SELECTED}
mkdir -p $HOME/Phone
mkdir -p $HOME/Temp
mkdir -p $HOME/.soft
mkdir -p $HOME/.cache/bash
mkdir -p $HOME/.vim/undodir

HOSTNAME=$(hostname)

echo "==> Reloading shell config..."
source ~/.bashrc
source ~/.bash_aliases

echo "==> Restoring private backup files..."
chown $USER:$USER -R $HOME/Backup/$HOSTNAME/
find ~/Backup/$HOSTNAME/ -type f -exec chmod 600 '{}' \;
mkdir $HOME/.cert
mkdir $HOME/.ssh
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/hosts /etc/
sudo cp -rf $HOME/Backup/$HOSTNAME/root/* /root/
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/NetworkManager/system-connections/* /etc/NetworkManager/system-connections/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/NetworkManager/dispatcher.d/ /etc/NetworkManager/dispatcher.d/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/wireguard/* /etc/wireguard/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/systemd/system/*.service /etc/systemd/system/ 
sudo cp -rf $HOME/Backup/$HOSTNAME/etc/systemd/system/*.timer /etc/systemd/system/ 
cp -rf $HOME/Backup/$HOSTNAME/.ssh/* $HOME/.ssh/ 
chmod 600 $HOME/.ssh/* -R
cp -rf $HOME/Backup/$HOSTNAME/.cert/* $HOME/.cert/ 
cp -rf $HOME/Backup/$HOSTNAME/.scripts/* $HOME/.scripts/ 
chmod u+x $HOME/.scripts/* $HOME/.scripts/*/* 
cp -rf $HOME/Backup/$HOSTNAME/.config/* $HOME/.config/ 
cp -rf $HOME/Backup/$HOSTNAME/.env_priv $HOME/

echo "==> Restart Network Manager..."
sudo nmcli conn reload

echo "==> Enabling up backup_private_files systemd unit..."
sudo systemctl enable --now smy.backup_private_files.timer

echo "==> Finalizing dotfiles and git config..."
config remote set-url origin git@github.com:Michail-Sergievsky/dotfiles.git
config push --set-upstream origin main

echo "==> Finalizing Vim setup..."
vim -E -s +PlugUpgrade +PlugUpdate +helptags ALL +qall
sudo cp -r $HOME/.vim /root/
sudo mkdir -p /root/.config

echo "==> Setting up vifm config..."
$HOME/.config/vifm/scripts/bash_alias_to_vifm_commands.sh
sudo cp -r $HOME/.config/vifm /root/.config/
sudo sed -i 's/colorscheme solarized-light-256 Default-256 Default/" colorscheme solarized-light-256 Default-256 Default/' /root/.config/vifm/vifmrc 
sudo sed -i 's/" colorscheme solarized-light-256-r.vifm/colorscheme solarized-light-256-r.vifm/' /root/.config/vifm/vifmrc 

echo "==> Creating symlink to Mounted directory..."
sudo mkdir -p /run/media/$USER
sudo ln -s /run/media/$USER ~/Mounted

echo "==> Excluding mount point from locate DB..."
echo 'PRUNEPATHS = "/run/media"' | sudo tee -a /etc/updatedb.conf > /dev/null

echo "==> Copying skeleton configs..."
sudo cp -r /arch_install/files/skel/.bash_logout /etc/skel
sudo cp -r /arch_install/files/skel/.bash_profile /etc/skel
sudo cp -r /arch_install/files/skel/.bashrc /etc/skel

echo "==> Setting up reflector weekly config..."
sudo cp -r /arch_install/files/xdg/reflector/reflector.conf /etc/xdg/reflector/

# OPTIONAL UPS CONFIG
#sudo cp -r /arch_install/files/pwrstatd.conf /etc/

echo "==> Setting up pacman cache cleanup hook..."
sudo mkdir -p /etc/pacman.d/hooks/
sudo cp -r /arch_install/files/pacman-cache-cleanup.hook /etc/pacman.d/hooks/

echo "==> Setting up Google Drive rclone bisync..."
rclone bisync ~/GoogleDrive gdrive: --resync
systemctl --user daemon-reload
systemctl --user enable --now rclone-sync.timer

echo -e "\e[1;32m==> PHASE 2 COMPLETE — System is now configured and ready!\e[0m"

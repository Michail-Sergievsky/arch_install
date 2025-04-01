#!/bin/bash
echo "==> Installing pacman packages for work"
for pkg in vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch docker docker-compose ansible wireshark-cli wireshark-qt freerdp virt-manager python-psycopg2; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_work_apps-pacman-notfound.txt
    fi
done

echo "==> Installing yay packages for work"
for pkg in kesl kesl-gui remmina rocketchat-client-bin; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        yay -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_work_apps-yay-notfound.txt
    fi
done

# adding to groups
sudo usermod -aG docker $USER
sudo usermod -aG wireshark $USER

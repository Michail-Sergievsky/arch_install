#!/bin/bash
echo "==> Installing pacman packages for work"
for pkg in vagrant virtualbox virtualbox-guest-iso virtualbox-host-modules-arch docker docker-compose ansible wireshark-cli wireshark-qt freerdp virt-manager python-psycopg2 openfortivpn; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_work_apps-pacman-notfound.txt
    fi
done

echo "==> Installing pandoc + LaTeX toolchain"
for pkg in pandoc texlive-basic texlive-latexextra texlive-xetex texlive-fontsrecommended noto-fonts noto-fonts-cjk noto-fonts-emoji; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_pandoc_latex-notfound.txt
    fi
done

echo "==> Building LaTeX formats (xelatex.fmt etc.)"
sudo fmtutil-sys --all

echo "==> Updating font cache"
fc-cache -f -v

echo "==> Installing yay packages for work"
for pkg in kesl kesl-gui remmina rocketchat-client-bin networkmanager-fortisslvpn; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        yay -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_work_apps-yay-notfound.txt
    fi
done

# adding to groups
sudo usermod -aG docker $USER
sudo usermod -aG wireshark $USER

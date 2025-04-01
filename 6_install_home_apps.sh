#!/bin/bash
echo "==> Installing pacman packages for install_home_apps"
for pkg in aegisub discord foliate gimagereader-gtk gimp handbrake hunspell-en_us hyphen-en kdenlive languagetool libreoffice-fresh libreoffice-fresh-ru obs-studio pinta tenacity tesseract tesseract-data-eng tesseract-data-rus thunderbird sox opus-tools mac; do
    if pacman -Si "$pkg" > /dev/null 2>&1; then
        sudo pacman -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_home_apps-pacman-notfound.txt
    fi
done

echo "==> Installing yay packages for install_home_apps"
for pkg in anki drawio-desktop ffmpeg-normalize flacon freac goldendict-ng google-chrome hibernator hunspell-ru hyphen-ru i3-gnome-pomodoro-git libreoffice-extension-languagetool llm networkmanager-fortisslvpn shell-gpt ttf-ms-fonts ttf-wps-fonts wps-office wps-office-all-dicts-win-languages zoom; do
    if yay -Si "$pkg" > /dev/null 2>&1 || yay -A --print "$pkg" > /dev/null 2>&1; then
        yay -S --noconfirm --needed "$pkg"
    else
        echo "$pkg" >> install_home_apps-yay-notfound.txt
    fi
done

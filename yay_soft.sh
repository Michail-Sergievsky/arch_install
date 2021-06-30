#!/bin/bash

#move yay to polybar.sh
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

#system
yay -S urxvt-resize-font-git nerd-fonts-source-code-pro siji-git ttf-weather-icons ttf-ms-fonts ly rofi-dmenu rofi-blezz rofi-greenclip simple-mtpfs dumptorrent hibernator

#soft 
yay -S zoom skypeforlinux-stable-bin transgui-gtk zoom hunspell-ru hyphen-ru libreoffice-extension-languagetool freac

systemctl --user enable greenclip.service
systemctl enable ly.service

rm -rf yay

printf "\e[1;32mNow dotfiles\e[0m"

#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#system
yay -S polybar

cd ..
rm -rf yay

printf "\e[1;32mNow dotfiles\e[0m"


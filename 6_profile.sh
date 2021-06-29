#!/bin/bash

xdg-user-dirs-update

mkdir -p Pictures/{Wall_use,screenshots,IMAGES_COPIED,IMAGES_SELECTED 
mkdir -p Download/{t_done,t_work,comics}
mkdir -p NetFolders
mkdir -p /run/media/freeman
ln -s /run/media/freeman ~/Mounted

mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged

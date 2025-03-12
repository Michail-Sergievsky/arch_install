#!/bin/bash
# Copy dotfiles
# LAUNCH FROM $HOME!!!!
if [ "$PWD" != "$HOME" ]; then
    echo "This script must be run from your home directory ($HOME). Exiting."
    exit 1
fi

rm -rf $HOME/.bashrc
rm -rf $HOME/.bash_profile
rm -rf $HOME/.bash_logout
git clone --bare https://github.com/Michail-Sergievsky/dotfiles.git $HOME/.myconf
function config {
   /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
config checkout
config config status.showUntrackedFiles no
config config user.email "mikhail.sergiev@gmail.com"
config config user.name "Michail-Sergievsky"

# HOME dirs
# xdg-user-dirs-update
mkdir -p $HOME/Downloads/{t_done,t_work,comics}
mkdir -p $HOME/GoogleDrive
mkdir -p $HOME/Media
mkdir -p $HOME/Pictures/{Wall_use,screenshots,IMAGES_COPIED,IMAGES_SELECTED}
mkdir -p $HOME/Phone
mkdir -p $HOME/Temp
mkdir -p $HOME/.soft
mkdir -p $HOME/.vim/undodir

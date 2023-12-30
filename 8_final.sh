#!/bin/bash

#generate passkey
user=$(echo $HOME | awk -F'/' '{print $3}')
ssh-keygen -b 2048 -t rsa -f /home/"$user"/.ssh/sshkey -q -N ""

# move pacman hooks
# add media to fstab

#links to firefox
# https://rutracker.org/forum/viewtopic.php?t=3468332&start=1080
# https://1337x.to/sub/70/0/
# https://1337x.to/sort-search/AV1/time/desc/1/
# https://nyaa.si/
# https://bakabt.me/browse.php
# https://torrentgalaxy.to/torrents.php?cat=19
# https://audiobookbay.is/
# https://rarelust.com/
# https://myduckisdead.org/page/2/
# http://192.169.2.3:9080/

# skype, zoom, discord

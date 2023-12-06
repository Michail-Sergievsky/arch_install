#!/bin/bash
cd /
touch swapfile

#change size
dd if=/dev/zero of=swapfile bs=1G count=16 status=progress

chmod 600 swapfile
mkswap /swapfile
swapon /swapfile
echo "#swapfile" >> /etc/fstab
echo "/swapfile none swap defaults 0 0" >> /etc/fstab


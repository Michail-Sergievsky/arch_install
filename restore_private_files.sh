#!/bin/bash
# copy private stuff back
sudo mkdir -p /etc/wireguard/
sudo cp -rf ~/Backup/host/etc/wireguard/wg-pc-client.conf /etc/wireguard/wg-pc-client.conf
sudo cp -rf ~/Backup/host/etc/hosts /etc/ &&
sudo cp -rf ~/Backup/host/etc/fstab /etc/ &&
# mkdir -p ~/.ssh
cp -rf ~/Backup/host/.ssh/ ~/.ssh/* 
cp -rf ~/Backup/host/.env_priv ~/

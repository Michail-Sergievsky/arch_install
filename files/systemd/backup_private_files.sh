#!/bin/bash

perform_backup() {
    mkdir -p /home/freeman/Backup/MPC/etc /home/freeman/Backup/MPC/etc/wireguard /home/freeman/Backup/MPC/.ssh && \
    cp -rf /etc/wireguard/wg-pc-client.conf /home/freeman/Backup/MPC/etc/wireguard && \ 
    cp -rf /etc/hosts /etc/fstab /home/freeman/Backup/MPC/etc && \
    cp -rf /home/freeman/.ssh/* /home/freeman/Backup/MPC/.ssh/ && \
	cp -rf /home/freeman/.env_priv /home/freeman/Backup/MPC && \
    chown freeman:freeman -R /home/freeman/Backup/MPC/
}

perform_backup

if [ $? -ne 0 ]; then
    sleep 1h
    perform_backup
fi

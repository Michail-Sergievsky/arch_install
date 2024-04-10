#!/bin/bash

perform_backup() {
    mkdir -p /home/tempuser/Backup/Host/etc /home/tempuser/Backup/Host/etc/wireguard /home/tempuser/Backup/Host/.ssh && \
    mkdir -p /home/tempuser/Backup/Host/etc/NetworkManager/system-connections && \
    mkdir -p /home/tempuser/Backup/Host/.cert/ && \
	mkdir -p /home/tempuser/Backup/Host/root/ && \
    cp -rf /etc/hosts /etc/fstab /home/tempuser/Backup/Host/etc && \
    cp -rf /etc/wireguard/* /home/tempuser/Backup/Host/etc/wireguard/ && \
    cp -rf /etc/NetworkManager/system-connections/* /home/tempuser/Backup/Host/etc/NetworkManager/system-connections/ && \
    cp -rf /home/tempuser/.ssh/* /home/tempuser/Backup/Host/.ssh/ && \
    cp -rf /home/tempuser/.cert/* /home/tempuser/Backup/Host/.cert/ && \
	cp -rf /root/* /home/tempuser/Backup/Host/root/ && \
	cp -rf /home/tempuser/.env_priv /home/tempuser/Backup/Host && \
    chown tempuser:tempuser -R /home/tempuser/Backup/Host/
}

perform_backup

if [ $? -ne 0 ]; then
    sleep 1h
    perform_backup
fi

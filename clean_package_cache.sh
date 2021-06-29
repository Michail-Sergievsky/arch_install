#!/bin/bash
mkdir -p /etc/pacman.d/hooks/clean.package_cache.hook
touch /etc/pacman.d/hooks/clean.package_cache.hook
echo "[Trigger]" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Operation = Upgrade" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Operation = Install" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Operation = Remove" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Type = Package" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Target = *" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "[Action]" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Description = Cleaning pacman cache..." >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "When = PostTransaction" >> /etc/pacman.d/hooks/clean.package_cache.hook
echo "Exec = /usr/bin/paccache -r" >> /etc/pacman.d/hooks/clean.package_cache.hook

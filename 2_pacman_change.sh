#!/bin/bash

#/etc/pacman.conf

#enable 32-bit apps
sed -i 's:#\[multilib\]:\[multilib\]:' $1
sed -i 's:#Include = \/etc\/pacman.d\/mirrorlist:Include = \/etc\/pacman.d\/mirrorlist:' $1
#enable parallel downloads
sed -i 's:#ParallelDownloads:ParallelDownloads:' $1

less $1


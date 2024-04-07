# Arch Basic Install Commands-Script
1. If needed, load your keymap
2. Refresh the servers with pacman -Syy
3. Partition the disk
4. Format the partitions
5. Mount the partitions
6. Install the base packages into /mnt

pacstrap /mnt base base-devel linux linux-firmware git vim intel-ucode (or amd-ucode)

7. Generate the FSTAB file with

genfstab -U /mnt >> /mnt/etc/FSTAB

8. Chroot in with

arch-chroot /mnt

9. Download the git repository with

git clone https://github.com/Michail-Sergievsky/arch_install.git

cd arch-install

chmod +x xxxx.sh

run with ./xxxx.sh

EDIT before executing!

First two execute under archroot, last part after reboot under new user.


1_archchroot_before_grub_install.sh - pacman setup, locale, time, hosts, hostname

2_archroot_grub_install.sh - grub, user, video , network drivers

3_soft.sh - installing soft

4_profile.sh - copying dotfiles and creating user directories

5_final.sh - hooks, restoring files and diffrent other things
    Copy Backup from flash drive!
    cp -r /path/to/source_directory/* /path/to/destination_directory
    cp -r /path/to/source_directory/. /path/to/destination_directory
        for hidden

# TODO
1. lscpu or something to choose intel-ucode or amd-ucode
2. Something to choose video drivers
3. Check for arch_install dir
4. ./script.sh | tee script.log - test more

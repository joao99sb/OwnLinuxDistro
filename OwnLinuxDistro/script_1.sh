#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
# set bios clock to system
hwclock --systohc

locale-gen

##################
#   Hostname     #
##################

echo "chose your Hostname: "
read HOSTNAME

echo $HOSTNAME >> /etc/hostname

echo "127.0.0.1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.0.1 ${HOSTNAME}.localdomain $HOSTNAME" >> /etc/hosts

echo "chose your root password: "
passwd 

pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog sudo

pacman -S grub-efi-x86_64 efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
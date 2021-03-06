#!/usr/bin/env bash

####################
#   wifi manager   #
####################
loadkeys br-abnt2
nmcli device wifi list
echo $WIFI_LIST 

echo -e "\n"
echo -e "chose your wifi:"
read WIFI
echo -e "password: "
read -s PASS_WIFI

nmcli device wifi connect "${WIFI}"  password "${PASS_WIFI}"

#################
#  add new user #
#################

echo "name of user: "
read USER

useradd -m ${USER}
passwd ${USER}


##########################
#  Desktop environments  #
##########################

pacman -S xorg plasma plasma-wayland-session kde-applications --noconfirm

systemctl enable sddm.service
systemctl enable NetworkManager.service

#add permitions manually

nano /etc/sudoers

reboot



#!/usr/bin/env bash

####################
#   wifi manager   #
####################

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

#add permitions manually

nano /etc/sudoers

##########################
#  Desktop environments  #
##########################

pacmna -S xorg plasma plasma-wayland-session kde-applications --noconfirm

systemctl enable sddm.service
systemctl enable NetworkManager.service
reboot



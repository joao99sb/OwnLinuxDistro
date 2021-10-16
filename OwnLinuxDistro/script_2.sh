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

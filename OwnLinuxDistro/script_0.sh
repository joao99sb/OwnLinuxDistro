#!/usr/bin/env bash


############################
#       wifi search        #
############################


# show interfaces devices
iw dev 
echo -e "\n"
echo -e "chose your network interface: "

read NETWORK_INTERFACE

ip link set $NETWORK_INTERFACE up || rfkill unblock wifi && ip link set $NETWORK_INTERFACE up


iw dev $NETWORK_INTERFACE scan | grep SSID

echo -e "chose your network: "

read WIFI

echo "password: "

read -s PASSWORD

iwctl --passphrase "${PASSWORD}" station "${NETWORK_INTERFACE}" connect "${WIFI}"

# I need to implement retry password as new feature




############################
#     Update pacman        #
############################

pacman -Syy

##########################################
# setting keyboard to brazilian standart #
##########################################

loadkeys br-abnt2

################################
#       Disk  partition        #
################################

DISK=/dev/sda
# make function to do the partition
# 1) show free space    fdisk -l <disk>
# 2) show partintions   lsblk <disk>
# 3) create partiiton

partition_function() {
    local isRunning=1

    if [ $1 -eq 5]
    then
        $isRunning=0
    fi

    while  [ ! $isRunning -eq 0]
    do
        echo "chose command "
        echo "0) to see free space"
        echo "1) to show partiotions"
        echo "5) to exit"
        
        read param
        partition_function $param

    done

}

echo "chose: ":
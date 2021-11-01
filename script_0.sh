#!/usr/bin/env bash
source ./functions/boot.sh

############################
#       wifi search        #
############################

# show interfaces devices
# iw dev
# echo -e "\n"
# echo -e "chose your network interface: "

# read NETWORK_INTERFACE

# ip link set $NETWORK_INTERFACE up || rfkill unblock wifi && ip link set $NETWORK_INTERFACE up

# iw dev $NETWORK_INTERFACE scan | grep SSID

# echo -e "chose your network: "

# read WIFI

# echo "password: "

# read -s PASSWORD

# iwctl --passphrase "${PASSWORD}" station "${NETWORK_INTERFACE}" connect "${WIFI}"

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



#partitions:
# /boot -> grub info (Recommendation: 500M) (type: EFI system) (formated: Fat32)
# /swap ( only if you don't wanna use swapfile) (type: Linux swap) (Recommendation: 2G)
# / (type: Linxu filesystem)


echo -e "####################"
echo -e "#  PARTITION Time  #"
echo -e "####################\n"

# this function will partitionate the hard disk

echo -e "what kind of boot do you want?\n"
bootTime(){
    echo -e "1) dual boot\n"
    echo -e "2) single boot\n"

    local read BOOT_OPT
    case $BOOT_OPT in
    1) dualBoot ;;
    2) singleboot ;;
    *) bootTime ;;
    esac
}


pacstrap /mnt base base-devel linux linux-firmware

cp ./script_1.sh /mnt/script_1.sh
cp ./script_2.sh /mnt/script_2.sh

genfstab -U -p /mnt >> /mnt/etc/fstab

##############################
#       init system          #
##############################

arch-chroot /mnt

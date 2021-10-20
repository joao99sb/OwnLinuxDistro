#!/usr/bin/env bash

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

device_list=($(lsblk -lnp | awk '{print $1}' | grep 'sd\|hd\|vd\|nvme\|mmcblk'))

lsblk -lnp

echo -e 'chose your device to partition:\n\n'

select device in ${device_list[@]}; do
    DISK=$device
    break
done

swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
swap_end=$(($swap_size + 129 + 1))MiB

parted -s $DISK -- mklabel gpt \
mkpart ESP fat32 1Mib 501Mib \
set 1 boot on \
mkpart primary linux-swap 501MiB ${swap_end} \
mkpart primary ext4 ${swap_end} 100%

part_boot="$(ls ${DISK}* | grep -E "^${DISK}p?1$")"
part_swap="$(ls ${DISK}* | grep -E "^${DISK}p?2$")"
part_root="$(ls ${DISK}* | grep -E "^${DISK}p?3$")"

mkfs.vfat -F32 "${part_boot}"
mkswap "${part_swap}"
mkfs.ext4 "${part_root}"

swapon "${part_swap}"

mount "${part_root}" /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount "${part_boot}" /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware

cp ./script_1.sh /mnt/script_1.sh
cp ./script_2.sh /mnt/script_2.sh

genfstab -U -p /mnt >> /mnt/etc/fstab

##############################
#       init system          #
##############################

arch-chroot /mnt

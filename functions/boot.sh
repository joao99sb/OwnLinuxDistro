#!/usr/bin/env bash

dualBoot() {
  cfdisk

  echo -e 'instructions\n'

  echo -e 'swap partition:'
  local read PART_SWAP
  mkswap "${PART_SWAP}"

  echo -e 'root partition: '
  local read PART_ROOT
  mkfs.ext4 "${PART_ROOT}"
  
  swapon "${part_swap}"

  mount "${part_root}" /mnt
  echo -e 'boot partition: '
  local read PART_BOOT

  mkdir /mnt/boot
  mkdir /mnt/boot/efi
  mount "${part_boot}" /mnt/boot/efi
  


}

singleboot() {
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
}

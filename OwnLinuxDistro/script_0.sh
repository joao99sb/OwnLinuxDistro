#!/usr/bin/env bash

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


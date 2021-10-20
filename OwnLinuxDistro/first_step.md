Buy default, this script is just for virtual machines (VirtualBox in my case)
UEFI MODE
network bridge


1) I need to update pacman and set keyboard to br-abnt2 (BR keyboard standart)

tips(wifi problem):\
- ip addr show ( net test )
- if you're using wifi: {
    - 1(manually): {   
        - verbouse: 
            - https://wiki.archlinux.org/title/Network_configuration_(Portugu%C3%AAs)/Wireless_(Portugu%C3%AAs)         
    },
    - 2(script):{
        - https://wiki.archlinux.org/title/Network_configuration_(Portugu%C3%AAs)/Wireless_(Portugu%C3%AAs)
    } 
}

2) Now I need to create disk partitions using parted or sfdisk, but sfdisk is not too god for GPT format, and it wasn't designed for large partitions. ( I need to study GPT format and others more )

obs: I decided to use parted, however if it doesn't work, I'll use cfdisk















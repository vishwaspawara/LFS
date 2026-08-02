#!/bin/bash

#run as root

set -oue pipefail


ROOT_DEV_UUID=$(blkid -s UUID -o value /dev/nvme0n1p3)
EFI_DEV_UUID=$(blkid -s UUID -o value /dev/nvme0n1p1)

cat > /etc/fstab << EOF
# Begin /etc/fstab

UUID=${ROOT_DEV_UUID}  /          ext4  defaults     1 1
UUID=${EFI_DEV_UUID}   /boot/efi  vfat  umask=0077   0 2

# End /etc/fstab
EOF

#since the system is efi

install -dv /boot/efi 

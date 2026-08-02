#!/bin/bash

set -euo pipefail

# UEFI boot entry numbers
DEBIAN_BOOT="0000"
LFS_BOOT="0001"

efibootmgr -o "${DEBIAN_BOOT},${LFS_BOOT}"

# by default update-grub do no run os-probler which is needed to add new entry in grub.cfg
if grep -q "^GRUB_DISABLE_OS_PROBER=" /etc/default/grub; then
    sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
else
    echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
fi

update-grub

efibootmgr


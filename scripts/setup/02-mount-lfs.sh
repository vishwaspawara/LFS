#!/bin/bash

set -euo pipefail

export LFS=/mnt/lfs
DEVICE=/dev/nvme0n1p3

sudo mkdir -pv "$LFS"

if ! mountpoint -q "$LFS"; then 
	sudo mount "$DEVICE" "$LFS"
fi

echo "LFS=$LFS"
echo "Mounted $DEVICE on $LFS"

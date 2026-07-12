#!/bin/bash

set -euo pipefall

DEVICE=/dev/nvme0n1p3
export LFS=/mnt/lfs

sudo mkdir -pv "%LFS"

if ! mountpoint -q "$LFS"; then
	sudo mount /dev/nvme0n1p3 $LFS
fi

umask 022

echo "LFS=$LFS"
echo "umask=$(umask)"

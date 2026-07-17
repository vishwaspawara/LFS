#!/bin/bash

set -euo pipefail

DEVICE="/dev/nvme0n1p3"
export LFS="/mnt/lfs"

sudo mkdir -pv "$LFS"

if ! mountpoint -q "$LFS"; then
	sudo mount "$DEVICE" "$LFS"
fi

umask 022

echo "LFS=$LFS"
echo "umask=$(umask)"

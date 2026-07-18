#!/bin/bash

set -euo pipefail

DEVICE="/dev/nvme0n1p3"
export LFS="/mnt/lfs"

echo "Running as: $(whoami)"
echo "LFS=$LFS"

[[ $EUID -eq 0 ]] || {
    echo "Run this script as root."
    exit 1
}

[[ "$LFS" == "/mnt/lfs" ]] || { exit 1; }

mkdir -pv "$LFS"

if ! mountpoint -q "$LFS"; then
    mount "$DEVICE" "$LFS"
fi

echo "$LFS mounted"

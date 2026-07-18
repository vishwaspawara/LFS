#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

mkdir -pv "$LFS"/{dev,proc,sys,run}

mountpoint -q "$LFS/dev"     || mount --bind /dev "$LFS/dev"
mountpoint -q "$LFS/dev/pts" || mount -t devpts devpts "$LFS/dev/pts" -o gid=5,mode=0620
mountpoint -q "$LFS/proc"    || mount -t proc proc "$LFS/proc"
mountpoint -q "$LFS/sys"     || mount -t sysfs sysfs "$LFS/sys"
mountpoint -q "$LFS/run"     || mount -t tmpfs tmpfs "$LFS/run"

if [ -h "$LFS/dev/shm" ]; then
    install -d -m 1777 "$LFS$(realpath /dev/shm)"
else
    mountpoint -q "$LFS/dev/shm" || mount -t tmpfs -o nosuid,nodev tmpfs "$LFS/dev/shm"
fi

echo "vfs ready."

findmnt -R "$LFS"

#!/bin/bash


export LFS=/mnt/lfs
sudo mount /dev/nvme0n1p3 $LFS

umask 022

echo "LFS=$LFS"
echo "umask=$(umask)"

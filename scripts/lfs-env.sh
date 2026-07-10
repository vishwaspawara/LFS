#!/bin/bash


export LFS=/mnt/lfs

umask 022

sudo mount /dev/nvme0n1p3 /mnt/lfs/


echo "LFS=$LFS"
echo "umask=$(umask)"

#!/bin/bash

set -oue pipefail

#make sure LFS variable is set in root environment
LFS="/mnt/lfs"

#umount the virtual file system
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}

#Now creating the tarball of build so far
cd $LFS
tar -cJpf $HOME/lfs-temp-tools-13.0-systemd.tar.xz . # replace the path as per convenience


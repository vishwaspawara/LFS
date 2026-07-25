#!/bin/bash

set -euo pipefail

LFS="/mnt/lfs"

# Unmount virtual filesystems if mounted
for mp in dev/shm dev/pts sys proc run dev; do
    mountpoint -q "$LFS/$mp" && umount "$LFS/$mp"
done

echo "Creating backup..."

tar \
    --xattrs \
    --acls \
    --numeric-owner \
    -cJpf "$HOME/lfs-before-strip.tar.xz" \
    -C "$LFS" .

echo "Backup complete."

#!/bin/bash
set -e

umount -v "$LFS/dev/pts" 2>/dev/null || true
umount -v "$LFS/dev/shm" 2>/dev/null || true
umount -v "$LFS/dev"     2>/dev/null || true
umount -v "$LFS/run"     2>/dev/null || true
umount -v "$LFS/proc"    2>/dev/null || true
umount -v "$LFS/sys"     2>/dev/null || true

umount -v "$LFS"

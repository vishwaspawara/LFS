#!/bin/bash

# dependecny of UEFI grub

set -euo pipefail

PACKAGE="efibootmgr-18"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile 
make EFIDIR=LFS EFI_LOADER=grubx64.efi

# install
make install EFIDIR=LFS

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


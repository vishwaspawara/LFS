#!/bin/bash

# dependecny of UEFI grub

set -euo pipefail

PACKAGE="grub-2.14"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# unset
unset {C,CPP,CXX,LD}FLAGS

# configure
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --disable-efiemu     \
            --with-platform=efi  \
            --target=x86_64      \
            --disable-werror


# compile 
make 

# install
make install 

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


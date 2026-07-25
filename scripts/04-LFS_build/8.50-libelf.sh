#!/bin/bash

# libelf for handling ELF (Executable and Linkable Formats) files

set -euo pipefail

PACKAGE="elfutils-0.194"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./config --prefix=/usr         \
         --disable-debuginfod  \
         --enable-libdebuginfod=dummy

# compile only libelf
make -C lib
make -C libelf

# install
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig

# remove static 
rm /usr/lib/libelf.a

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

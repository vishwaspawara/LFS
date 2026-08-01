#!/bin/bash

#contains linker, assembler and other tools

set -euo pipefail

PACKAGE="binutils-2.46.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile in separate build dir
mkdir -v build
cd build

# configure 
../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --enable-new-dtags  \
             --with-system-zlib  \
             --enable-default-hash-style=gnu

# compile 
make tooldir=/usr

# test these are critical
make -k check

# just confirm failed test is related to gprofng
grep '^FAIL:' $(find -name '*.log')

# install
make tooldir=/usr install

# remove static libraries
rm -rfv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a \
        /usr/share/doc/gprofng/

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

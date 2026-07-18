#!/bin/bash

#compression decompression routines used by some programs

set -euo pipefail

PACKAGE="zlib-1.3.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./configure --prefix=/usr

# compile
make 

# test 
make check

# install
make install

# Cleanup
rm -fv /usr/lib/libz.a #useless and static
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

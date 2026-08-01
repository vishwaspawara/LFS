#!/bin/bash

# gnu database manager

set -euo pipefail

PACKAGE="gdbm-1.26"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

# compile 
make 

# test 
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

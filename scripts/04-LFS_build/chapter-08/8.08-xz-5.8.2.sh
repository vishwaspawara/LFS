#!/bin/bash

#compression decompression txt files better yield than gzip or bzip2

set -euo pipefail

PACKAGE="xz-5.8.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.8.2


# compile 
make 

# test
make check

# install
make  install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

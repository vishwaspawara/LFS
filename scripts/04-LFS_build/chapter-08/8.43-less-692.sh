#!/bin/bash

# text file viewer

set -euo pipefail

PACKAGE="less-692"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --sysconfdir=/etc

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

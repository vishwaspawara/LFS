#!/bin/bash

#package contains utilities to administer the extended attributes of filesystem objects

set -euo pipefail

PACKAGE="attr-2.5.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --disable-static     \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.2

# compile 
make 

# test these are critical
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

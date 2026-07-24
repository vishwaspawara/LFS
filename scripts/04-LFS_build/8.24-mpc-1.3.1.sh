#!/bin/bash

#package math libraries (multiple precision mathi and correct rounding)

set -euo pipefail

PACKAGE="mpc-1.3.1"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --disable-static     \
            --docdir=/usr/share/doc/mpc-1.3.1

# compile 
make 
make html

# test these are critical
make check

# install
make install
make install-html

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

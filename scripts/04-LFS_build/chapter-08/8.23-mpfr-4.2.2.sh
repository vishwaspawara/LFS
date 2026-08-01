#!/bin/bash

#package math libraries (multiple precision math)

set -euo pipefail

PACKAGE="mpfr-4.2.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.2

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

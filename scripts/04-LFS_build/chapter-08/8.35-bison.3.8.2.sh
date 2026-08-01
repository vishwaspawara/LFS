#!/bin/bash

#package parser generator

set -euo pipefail

PACKAGE="bison-3.8.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --docdir=/usr/share/doc/${PACKAGE}

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

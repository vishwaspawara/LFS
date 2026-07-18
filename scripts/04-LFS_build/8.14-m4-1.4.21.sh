#!/bin/bash

#package that contains macro processor

set -euo pipefail

PACKAGE="m4-1.4.21"

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

# Cleanu
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

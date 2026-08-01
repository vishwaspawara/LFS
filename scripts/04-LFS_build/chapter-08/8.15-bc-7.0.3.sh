#!/bin/bash

#command line calculator

set -euo pipefail

PACKAGE="bc-7.0.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
# using gcc c99 c standard, 
# -G ommit test suits that requies bc to be installed, 
# -O3 optimization to use (gcc level 3 aggressive speed optimization)
# -r enable use of readline
CC='gcc -std=c99' ./configure --prefix=/usr -G -O3 -r

# compile 
make 

# test
make test

# install
make install

# Cleanu
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

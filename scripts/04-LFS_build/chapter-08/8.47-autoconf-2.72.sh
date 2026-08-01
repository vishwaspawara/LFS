#!/bin/bash

# automatically configure source code.

set -euo pipefail

PACKAGE="autoconf-2.72"

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
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

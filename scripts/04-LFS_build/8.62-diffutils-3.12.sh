#!/bin/bash

# contains programs that show diff between tow files or dir such as diff, cmp

set -euo pipefail

PACKAGE="diffutils-3.1"

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


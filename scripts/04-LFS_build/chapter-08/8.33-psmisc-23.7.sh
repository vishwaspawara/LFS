#!/bin/bash

#package contains programs to display information about running processes

set -euo pipefail

PACKAGE="pscmisc-23.7"

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

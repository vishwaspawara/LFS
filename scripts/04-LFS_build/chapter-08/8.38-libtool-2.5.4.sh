#!/bin/bash

# generic library support script

set -euo pipefail

PACKAGE="libtool-2.5.4"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
/configure --prefix=/usr

# compile 
make 

# test 
make check

# install
make install

# remove static library used for test suite
rm -fv /usr/lib/libltdl.a

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

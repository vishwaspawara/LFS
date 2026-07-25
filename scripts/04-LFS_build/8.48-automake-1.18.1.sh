#!/bin/bash

# programs for generating Makefiles used with autoconf

set -euo pipefail

PACKAGE="automake-1.18.1"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./configure --prefix=/usr --docdir=/usr/share/doc/${PACKAGE}

# compile 
make 

# test 
# make -j$(($(nproc)>4?$(nproc):4)) check # this can be run to test using as many corse of given system
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

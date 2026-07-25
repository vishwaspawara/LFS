#!/bin/bash

# generates perfect hash key from key set.

set -euo pipefail

PACKAGE="gperf-3.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr    \
            --docdir=/usr/share/doc/gperf-3.3

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

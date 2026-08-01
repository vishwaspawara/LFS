#!/bin/bash

#real time compression 

set -euo pipefail

PACKAGE="lz4-1.10.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile 
make prefix=/usr

# test
make check

# install
make prefix=/usr install

# Cleanup
rm -v /usr/lib/libzstd.a
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

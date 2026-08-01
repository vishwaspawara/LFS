#!/bin/bash

#compression speed better than 500MB/s per core

set -euo pipefail

PACKAGE="lz4-1.10.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile 
make BUILD_STATIC=no PREFIX=/usr

# test
make -j1 check

# install
make BUILD_STATIC=no PREFIX=/usr install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

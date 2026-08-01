#!/bin/bash

# this package contains libraries and utilities for loading kernel modules

set -euo pipefail

PACKAGE="kmod-34.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build in separate buil dir
mkdir -p build
cd build

# configure 
meson setup --prefix=/usr ..    \
            --buildtype=release \
            -D manpages=false

# compile
ninja

# install
ninja install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

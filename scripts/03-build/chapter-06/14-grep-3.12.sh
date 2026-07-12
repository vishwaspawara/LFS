#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf grep-3.12.tar.xz
cd grep-3.12

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./build-aux/config.guess)"

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
cd "$LFS/sources"
rm -rf grep-3.12

echo "Grep installed successfully."

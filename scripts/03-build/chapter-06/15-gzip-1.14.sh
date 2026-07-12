#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf gzip-1.14.tar.xz
cd gzip-1.14

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT"

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
cd "$LFS/sources"
rm -rf gzip-1.14

echo "Gzip installed successfully."

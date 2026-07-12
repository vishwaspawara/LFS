#!/bin/bash
set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf sed-4.9.tar.xz
cd sed-4.9

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)"

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
cd "$LFS/sources"
rm -rf sed-4.9

echo "Sed installed successfully."

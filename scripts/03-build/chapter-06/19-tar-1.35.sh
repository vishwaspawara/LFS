#!/bin/bash
set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf tar-1.35.tar.xz
cd tar-1.35

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
rm -rf tar-1.35

echo "Tar installed successfully."

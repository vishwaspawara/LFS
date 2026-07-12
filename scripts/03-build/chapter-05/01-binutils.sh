#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf binutils-2.46.0.tar.xz
cd binutils-2.46.0

# Out-of-source build
mkdir -v build
cd build

# Configure
../configure \
    --prefix="$LFS/tools" \
    --with-sysroot="$LFS" \
    --target="$LFS_TGT" \
    --disable-nls \
    --enable-gprofng=no \
    --disable-werror \
    --enable-new-dtags \
    --enable-default-hash-style=gnu

# Build
make

# Install
make install

# Cleanup
cd "$LFS/sources"
rm -rf binutils-2.46.0

echo "Binutils Pass 1 completed."

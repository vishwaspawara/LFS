#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf binutils-2.46.0.tar.xz
cd binutils-2.46.0

# Prevent libtool from embedding unnecessary runtime library paths
sed '6031s/$add_dir//' -i ltmain.sh

# Out-of-source build
mkdir -v build
cd build

# Configure
../configure \
    --prefix=/usr \
    --build="$(../config.guess)" \
    --host="$LFS_TGT" \
    --disable-nls \
    --enable-shared \
    --enable-gprofng=no \
    --disable-werror \
    --enable-64-bit-bfd \
    --enable-new-dtags \
    --enable-default-hash-style=gnu

# Build
make

# Install
make DESTDIR="$LFS" install

# Remove unnecessary static libraries and libtool archives (can interfare with cross compilation)
rm -v "$LFS"/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

# Cleanup
cd "$LFS/sources"
rm -rf binutils-2.46.0

echo "Binutils Pass 2 installed successfully."

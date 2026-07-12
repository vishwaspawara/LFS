#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf xz-5.8.2.tar.xz
cd xz-5.8.2

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)" \
    --disable-static \
    --docdir=/usr/share/doc/xz-5.8.2

# Build
make

# Install
make DESTDIR="$LFS" install

# Remove unnecessary libtool archive (harmful for cross compilation)
rm -v "$LFS/usr/lib/liblzma.la"

# Cleanup
cd "$LFS/sources"
rm -rf xz-5.8.2

echo "XZ Utils installed successfully."

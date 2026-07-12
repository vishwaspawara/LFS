#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf file-5.46.tar.gz
cd file-5.46

# Build a native 'file' utility for the host
mkdir -v build
pushd build

../configure \
    --disable-bzlib \
    --disable-libseccomp \
    --disable-xzlib \
    --disable-zlib

make

popd

# Configure for the target system
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./config.guess)"

# Build using the host 'file' utility built above
make FILE_COMPILE="$(pwd)/build/src/file"

# Install
make DESTDIR="$LFS" install

# Remove unnecessary libtool archive (harmful for cross compilation)
rm -v "$LFS/usr/lib/libmagic.la"

# Cleanup
cd "$LFS/sources"
rm -rf file-5.46

echo "File installed successfully."

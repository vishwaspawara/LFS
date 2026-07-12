#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract 
tar -xf gcc-15.2.0.tar.xz
cd gcc-15.2.0

# Build in separate build dir
mkdir -v build
cd build

# Configure
../libstdc++-v3/configure \
    --host="$LFS_TGT" \
    --build="$(../config.guess)" \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir=/tools/"$LFS_TGT"/include/c++/15.2.0

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
# remove the libtool archives because they are harmful for cross compilation
rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la

cd "$LFS/sources"
rm -rf gcc-15.2.0

echo "Libstdc++ Pass 1 installed."

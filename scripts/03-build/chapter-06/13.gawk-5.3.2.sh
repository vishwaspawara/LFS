#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf gawk-5.3.2.tar.xz
cd gawk-5.3.2

# Prevent building the 'extras' directory
sed -i 's/extras//' Makefile.in

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
rm -rf gawk-5.3.2

echo "Gawk installed successfully."

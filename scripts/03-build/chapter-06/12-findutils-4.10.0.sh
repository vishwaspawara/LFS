#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf findutils-4.10.0.tar.xz
cd findutils-4.10.0

# Configure
./configure \
    --prefix=/usr \
    --localstatedir=/var/lib/locate \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)"

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
cd "$LFS/sources"
rm -rf findutils-4.10.0

echo "Findutils installed successfully."

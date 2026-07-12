#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf bash-5.3.tar.gz
cd bash-5.3

# Configure
./configure \
    --prefix=/usr \
    --build="$(sh support/config.guess)" \
    --host="$LFS_TGT" \
    --without-bash-malloc

# Build
make

# Install
make DESTDIR="$LFS" install

# Create /bin/sh symlink
ln -sfv bash "$LFS/bin/sh"

# Cleanup
cd "$LFS/sources"
rm -rf bash-5.3

echo "Bash installed successfully."

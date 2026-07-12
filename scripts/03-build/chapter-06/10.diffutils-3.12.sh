#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf diffutils-3.12.tar.xz
cd diffutils-3.12

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    gl_cv_func_strcasecmp_works=y \
    --build="$(./build-aux/config.guess)"

# Build
make

# Install
make DESTDIR="$LFS" install

# Cleanup
cd "$LFS/sources"
rm -rf diffutils-3.12

echo "Diffutils installed successfully."

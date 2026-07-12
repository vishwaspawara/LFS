#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

cd "$LFS/sources"

# Extract Linux kernel source
tar -xf linux-6.18.10.tar.xz
cd linux-6.18.10

# Remove stale build artifacts (stronger than make clean)
make mrproper

# Generate userspace headers
make headers

# Keep only header files
find usr/include -type f ! -name '*.h' -delete

# Install headers
cp -rv usr/include "$LFS/usr"

# Cleanup
cd "$LFS/sources"
rm -rf linux-6.18.10

echo "Linux API Headers installed."

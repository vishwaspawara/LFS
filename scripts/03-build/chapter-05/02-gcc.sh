#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract GCC
tar -xf gcc-15.2.0.tar.xz
cd gcc-15.2.0

# Extract required libraries and rename
tar -xf ../mpfr-4.2.2.tar.xz
mv -v mpfr-4.2.2 mpfr

tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp

tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# Use lib instead of lib64 match and replace
case "$(uname -m)" in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
esac

mkdir -v build
cd build

# Configure
../configure \
    --target="$LFS_TGT" \
    --prefix="$LFS/tools" \
    --with-glibc-version=2.43 \
    --with-sysroot="$LFS" \
    --with-newlib \
    --without-headers \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-fixincludes \
    --disable-nls \
    --disable-shared \
    --disable-multilib \
    --disable-threads \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libssp \
    --disable-libvtv \
    --disable-libstdcxx \
    --enable-languages=c,c++

# Build
make

# Install 
make install

# Install temporary limits.h
cat ../gcc/{limitx,glimits,limity}.h > \
    "$("$LFS_TGT"-gcc -print-file-name=include)/limits.h"

# Cleanup
cd "$LFS/sources"
rm -rf gcc-15.2.0

echo "GCC Pass 1 completed."

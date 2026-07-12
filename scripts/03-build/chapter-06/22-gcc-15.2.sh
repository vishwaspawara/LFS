#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf gcc-15.2.0.tar.xz
cd gcc-15.2.0

# Extract required libraries
tar -xf ../mpfr-4.2.2.tar.xz
mv -v mpfr-4.2.2 mpfr

tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp

tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

# Install 64-bit libraries in /lib instead of /lib64
case "$(uname -m)" in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
esac

# Use POSIX threads by default
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in \
       libstdc++-v3/include/Makefile.in

# Out-of-source build
mkdir -v build
cd build

# Configure
../configure \
    --build="$(../config.guess)" \
    --host="$LFS_TGT" \
    --target="$LFS_TGT" \
    --prefix=/usr \
    --with-build-sysroot="$LFS" \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-nls \
    --disable-multilib \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libsanitizer \
    --disable-libssp \
    --disable-libvtv \
    --enable-languages=c,c++ \
    LDFLAGS_FOR_TARGET="-L$PWD/$LFS_TGT/libgcc"

# Build
make

# Install
make DESTDIR="$LFS" install

# Provide the conventional C compiler name
ln -sfv gcc "$LFS/usr/bin/cc"

# Cleanup
cd "$LFS/sources"
rm -rf gcc-15.2.0

echo "GCC Pass 2 installed successfully."

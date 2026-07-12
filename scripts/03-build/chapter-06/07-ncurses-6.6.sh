#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf ncurses-6.6.tar.gz
cd ncurses-6.6

# Build a native 'tic' utility for the host
mkdir -v build
pushd build

../configure \
    --prefix="$LFS/tools" \
    AWK=gawk

make -C include
make -C progs tic
install -v progs/tic "$LFS/tools/bin"

popd

# Configure for the target system
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./config.guess)" \
    --mandir=/usr/share/man \
    --with-manpage-format=normal \
    --with-shared \
    --without-normal \
    --with-cxx-shared \
    --without-debug \
    --without-ada \
    --disable-stripping \
    AWK=gawk

# Build
make

# Install
make DESTDIR="$LFS" install

# Compatibility symlink
ln -sfv libncursesw.so "$LFS/usr/lib/libncurses.so"

# Enable wide-character support by default
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i "$LFS/usr/include/curses.h"

# Cleanup
cd "$LFS/sources"
rm -rf ncurses-6.6

echo "Ncurses installed successfully."

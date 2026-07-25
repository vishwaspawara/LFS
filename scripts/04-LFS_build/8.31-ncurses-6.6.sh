#!/bin/bash

#terminal independent handling of character screens

set -euo pipefail

PACKAGE="ncurses-6.6"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# copile in build dir
mkdir -v build
cd build

# configure 

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --with-cxx-shared       \
            --enable-pc-files       \
            --with-pkg-config-libdir=/usr/lib/pkgconfig

# compile 
make 

# install override earlier install of ncurses
make DESTDIR=$PWD/dest install
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i dest/usr/include/curses.h
cp --remove-destination -av dest/* /

# fix for non-wide character ncurses libraries
for lib in ncurses form panel menu ; do
    ln -sfv lib${lib}w.so /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc    /usr/lib/pkgconfig/${lib}.pc
done

# check compatibility with old application which used -lcurses at build time
ln -sfv libncursesw.so /usr/lib/libcurses.so

# copy desired documentation
cp -v -R doc -T /usr/share/doc/ncurses-6.6

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

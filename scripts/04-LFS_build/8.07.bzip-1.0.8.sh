#!/bin/bash

#compression decompression better yield than gzip

set -euo pipefail

PACKAGE="bzip2-1.0.8"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# patch for documentation install
patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

# relative sym links
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

#Ensure the man pages are installed into the correct location:
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# compile the library using different makefile
make -f Makefile-libbz2_so
make clean #remove shared file build by shared library

# compile static library and program
make 

# install
make PREFIX=/usr install
cp -av libbz2.so.* /usr/lib
ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so
ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so.1 #compatibility symlink

cp -v bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 $i
done

# Cleanup
rm -fv /usr/lib/libbz2.a #useless and static
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

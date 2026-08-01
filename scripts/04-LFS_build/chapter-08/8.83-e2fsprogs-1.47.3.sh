#!/bin/bash

# package contains utilities to handle ext2 system, also supports ext{3,4}

set -euo pipefail

PACKAGE="e2fsprogs-1.47.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build dir 
mkdir -v build
cd build

# configure 
../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-elf-shlibs \
             --disable-libblkid  \
             --disable-libuuid   \
             --disable-uuidd     \
             --disable-fsck

# compile 
make 

# test 
make check

# install
make install

# remove static files 
rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

# install info after extracting
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

# create additional docs
makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


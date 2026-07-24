#!/bin/bash

#package contains contains a modern library for one way hashing of passwords

set -euo pipefail

PACKAGE="libxcrypt-4.5.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# fix required by glibc-2.43
sed -i '/strchr/s/const//' lib/crypt-{sm3,gost}-yescrypt.c

# configure 
# enable-hashes=strong,glibc create strong hash algorithms
# disabling obsolete api - not needed for modern linux build from source
# failure tokens linux system based on glibc does not need this
./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=no     \
            --disable-static             \
            --disable-failure-tokens

# compile 
make 

# test 
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

#!/bin/bash

# management tools and libraries relating to cryptography- useful to other packages such as openssh, email application and web browsers 

set -euo pipefail

PACKAGE="openssl-3.6.1"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

# compile 
make 

# test 
HARNESS_JOBS=$(nproc) make test

# install
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

# add version to the doc and (optionally) copy additional documents
mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.6.1
cp -vfr doc/* /usr/share/doc/openssl-3.6.1

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

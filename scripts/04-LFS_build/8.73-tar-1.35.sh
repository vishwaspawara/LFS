#!/bin/bash

# archive manipulation tool

set -euo pipefail

PACKAGE="tar-1.35"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure allowing mknod to run as root
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr

# compile 
make 

# test 
make check

# install
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.35 #docs


# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


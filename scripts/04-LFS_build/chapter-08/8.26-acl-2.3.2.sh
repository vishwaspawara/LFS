#!/bin/bash

#package contains utilities to administer Access Control Lists used to define access rights for files and dir

set -euo pipefail

PACKAGE="acl-2.3.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr        \
            --disable-static     \
            --docdir=/usr/share/doc/acl-2.3.2

# compile 
make 

# test these are critical
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

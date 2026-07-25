#!/bin/bash

# programs relating to processing and formatting text and images

set -euo pipefail

PACKAGE="groff-1.23.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
PAGE=A4 ./configure --prefix=/usr

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


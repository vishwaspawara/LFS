#!/bin/bash

# managing pipeline of subprocesses in flexible and conventional way

set -euo pipefail

PACKAGE="libpipeline-1.5.8"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr 

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


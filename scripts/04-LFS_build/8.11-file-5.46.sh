#!/bin/bash

#used to determine the type of file

set -euo pipefail

PACKAGE="file-5.46"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile 
make prefix=/usr

# test
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

#!/bin/bash

set -euo pipefail

PACKAGE="texinfo-7.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# Configure
./Configure --prefix=/usr 

# Build
make

# Install
make install


# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

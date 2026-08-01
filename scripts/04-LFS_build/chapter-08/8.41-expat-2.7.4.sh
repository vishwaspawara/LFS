#!/bin/bash

# c based library for parsing XML

set -euo pipefail

PACKAGE="expat-2.7.4"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr    \
	    --disable-static \
            --docdir=/usr/share/doc/${PACKAGE}

# compile 
make 

# test 
make check

# install
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/${PACKAGE}

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

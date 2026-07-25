#!/bin/bash

#package contains utilities for internationalization and localization.

set -euo pipefail

PACKAGE="gettext-1.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-1.0
# compile 
make 

# test
make check

# install 
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

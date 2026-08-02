#!/bin/bash

# dependecny of efibootmgr

set -euo pipefail

PACKAGE="pop-1.19"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr --disable-static

# compile 
make 

# install
make install
install -v -m755 -d /usr/share/doc/popt-1.19 &&
install -v -m644 doxygen/html/* /usr/share/doc/popt-1.19

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


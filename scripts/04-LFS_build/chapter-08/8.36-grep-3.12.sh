#!/bin/bash

#searching tool through file content

set -euo pipefail

PACKAGE="grep-3.12"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# remove warning about egrep and fgrep that makes tests fail on some packages
sed -i "s/echo/#echo/" src/egrep.sh

# configure 
./configure --prefix=/usr

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

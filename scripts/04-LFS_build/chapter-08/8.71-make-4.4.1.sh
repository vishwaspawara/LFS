#!/bin/bash

# program to generate and control of executables and other non-source files from source

set -euo pipefail

PACKAGE="make-4.4.1"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr

# compile 
make 

# test 
chown -R tester .
su tester -c "PATH=$PATH make check"

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


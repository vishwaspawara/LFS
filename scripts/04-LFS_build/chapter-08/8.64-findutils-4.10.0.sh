#!/bin/bash

# findutils find and locate and supporting programs

set -euo pipefail

PACKAGE="findutils-4.10.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr --localstatedir=/var/lib/locate

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


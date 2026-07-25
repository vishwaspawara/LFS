#!/bin/bash

#the stream editor

set -euo pipefail

PACKAGE="sed-4.9"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr

# compile 
make 
make html

# test
chown -R tester .
su tester -c "PATH=$PATH make check"


# install 
make install
install -d -m755           /usr/share/doc/sed-4.9
install -m644 doc/sed.html /usr/share/doc/sed-4.9

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

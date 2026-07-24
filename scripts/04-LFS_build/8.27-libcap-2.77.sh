#!/bin/bash

#package partitions root privileges into set of distinct privileges.

set -euo pipefail

PACKAGE="libcap-2.77"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# prevent static libraries from being installed 
sed -i '/install -m.*STA/d' libcap/Makefile

# compile  (lib=lib set /usr/lib instead of /usr/lib64)
make prefix=/usr lib=lib

# test 
make test

# install
make prefix=/usr lib=lib install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

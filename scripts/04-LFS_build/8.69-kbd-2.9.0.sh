#!/bin/bash

# console fonts and keyboard utilities and key-table files

set -euo pipefail

PACKAGE="kbd-2.9.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# patch for inconsistency in backspace and delete keys
patch -Np1 -i ../kbd-2.9.0-backspace-1.patch

# removal of redundant resizecons program
sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

# configure disabling vlock as it requires PAM
./configure --prefix=/usr --disable-vlock

# compile 
make 

# test 
make check

# install
make install
cp -R -v docs/doc -T /usr/share/doc/kbd-2.9.0 #docs

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


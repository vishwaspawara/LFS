#!/bin/bash

#automates interactive programs

set -euo pipefail

PACKAGE="expect5.45.4"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# check PTY (pseudo teletypes - terminal)
# when another program wants to interact with terminal this is used
# PTY come in pairs MASTER owned by program and SLAVE always owned by bash
python3 -c 'from pty import spawn; spawn(["echo", "ok"])'

# Patch to allow the packages with gcc-15.1 or later
patch -Np1 -i ../expect-5.45.4-gcc15-1.patch

# configure and disable rpath hardcodding into binary executable
./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --disable-rpath         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

# compile 
make 

# test
make test

# install
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

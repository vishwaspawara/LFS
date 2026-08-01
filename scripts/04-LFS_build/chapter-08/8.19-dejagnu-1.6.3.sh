#!/bin/bash

#automates interactive programs (used for testing)

set -euo pipefail

PACKAGE="dejagnu-1.6.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# dedicated build dir
mkdir -v build
cd build

# configure 
./configure --prefix=/usr 

# makeinfo in gcc but for creating documentation from code
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

# compile (make check is dependent on make)
make check

# install
make install
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

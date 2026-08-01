#!/bin/bash

#package math libraries

set -euo pipefail

PACKAGE="gmp-6.3.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# add compatibility with gcc-15 or later
# search line containing 'long long t1;' and plus 1 line then perform replacement of () with (...)
sed -i '/long long t1;/,+1s/()/(...)/' configure

# configure 
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0
# compile 
make 
make html

# test these are critical, store in file
make check 2>&1 |tee gmp-check-log

# just confirm 199 test have passed, 
awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

# install
make install
make install-html

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

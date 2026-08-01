#!/bin/bash

#contains new generation perl compatible Regular Expression libraries

set -euo pipefail

PACKAGE="pcre2-10.47"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/pcre2-10.47 \
            --enable-unicode                    \
            --enable-jit                        \
            --enable-pcre2-16                   \
            --enable-pcre2-32                   \
            --enable-pcre2grep-libz             \
            --enable-pcre2grep-libbz2           \
            --enable-pcre2test-libreadline      \
            --disable-static

# compile 
make 

# test
make check

# install
make install

# Cleanu
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

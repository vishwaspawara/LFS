#!/bin/bash

#patter recognition in text

set -euo pipefail

PACKAGE="flex-2.6.4"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/flex-2.6.4

# compile 
make 

# test
make check

# install
make install
ln -sv flex   /usr/bin/lex #also refered to as lex
ln -sv flex.1 /usr/share/man/man1/lex.1 #create man page link to lex

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

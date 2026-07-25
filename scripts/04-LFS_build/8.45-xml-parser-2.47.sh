#!/bin/bash

# internationalization tool used for extracted translatable strings from source file

set -euo pipefail

PACKAGE="intltool-0.51.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# fix warning that is caused by perl-5.22 and later
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

# configure
./configure --prefix=/usr

# compile 
make 

# test 
make check

# install
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

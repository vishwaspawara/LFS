#!/bin/bash

# programs to monitor process top, ps, pkill, watch, etc

set -euo pipefail

PACKAGE="procps-ng-4.0.6"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.6 \
            --disable-static                        \
            --disable-kill                          \
            --enable-watch8bit                      \
            --with-systemd

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


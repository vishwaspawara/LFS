#!/bin/bash

# dependecny of efibootmgr

set -euo pipefail

PACKAGE="efivar-39"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# patch
patch -Np1 -i ../efivar-39-upstream_fixes-1.patch

# compile 
make ENABLE_DOCS=0

# install
make install ENABLE_DOCS=0 LIBDIR=/usr/lib
install -vm644 docs/efivar.1 /usr/share/man/man1 &&
install -vm644 docs/*.3      /usr/share/man/man3

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


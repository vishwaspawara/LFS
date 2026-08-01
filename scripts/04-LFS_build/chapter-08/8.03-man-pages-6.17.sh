#!/bin/bash

# manual pages describes c programming functions, important device files and configuration files.

set -euo pipefail

PACKAGE="man-pages-6.17"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# remove two man pages better version will be provided by Libxcrypt
rm -v man3/crypt*

# install
make -R GIT=false prefix=/usr install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

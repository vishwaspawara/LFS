#!/bin/bash

# python library for wheel packaging standards

set -euo pipefail

PACKAGE="wheel-0.46.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

# install
pip3 install --no-index --find-links dist wheel

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

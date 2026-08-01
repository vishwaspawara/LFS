#!/bin/bash

# distribution building part of flit - packaging tool for python modules

set -euo pipefail

PACKAGE="flit_core-3.12.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

# install
pip3 install --no-index --find-links dist flit_core

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

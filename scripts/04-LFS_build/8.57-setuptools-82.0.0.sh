#!/bin/bash

# tools used to download, build, install/uninstall and upgrade python packages.

set -euo pipefail

PACKAGE="setuptools-82.0.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

# install
pip3 install --no-index --find-links dist setuptools

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

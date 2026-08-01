#!/bin/bash

# a central library for Python Enhancement Proposal basically this esures the versioning logic is same across different libraries such that pip and other could interprete available packages for specific machine 

set -euo pipefail

PACKAGE="packaging-26.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

# install
pip3 install --no-index --find-links dist packaging

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

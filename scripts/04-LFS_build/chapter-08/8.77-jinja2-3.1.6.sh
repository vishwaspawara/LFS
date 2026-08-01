#!/bin/bash

# python module that implements simple pythonic template language

set -euo pipefail

PACKAGE="jinja2-3.1.6"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# compile 
pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

# install
pip3 install --no-index --find-links dist Jinja2

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


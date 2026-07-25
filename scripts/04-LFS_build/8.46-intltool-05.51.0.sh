#!/bin/bash

# perl interface to James Clark's XML parser, Expat.

set -euo pipefail

PACKAGE="XML-Parser-2.47"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# prepare XML::parser for compilation
perl Makefile.PL

# compile 
make 

# test 
make test

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

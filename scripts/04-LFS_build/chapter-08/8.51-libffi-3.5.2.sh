#!/bin/bash

# FFI stands for Foregn Function Interface, this become bridge between interpreted languages like pyton/perl and shared subroutings written in c/c++

set -euo pipefail

PACKAGE="elfutils-0.194"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure
./config --prefix=/usr         \
         --disable-static \
         --with-gcc-arch=native

# compile
make

# test
make check

# install
make install

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

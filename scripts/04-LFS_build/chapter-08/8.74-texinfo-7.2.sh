#!/bin/bash

# reading writing and converting info pages

set -euo pipefail

PACKAGE="exinfo-7.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# fix code pattern which causes perl-5.42 or later to display warning
sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm

# configure 
./configure --prefix=/usr

# compile 
make 

# test 
make check

# install
make install
make TEXMF=/usr/share/texmf install-tex # install components belonging to TeX installation

# sync issue resolution due to makefiles
pushd /usr/share/info
  rm -v dir
  for f in *
    do install-info $f dir 2>/dev/null
  done
popd

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


#!/bin/bash

# contains programs for basic and advanced ipv4 networking

set -euo pipefail

PACKAGE="iproute2-6.18.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# arpd related removal
sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

# compile 
make NETNS_RUN_DIR=/run/netns

# install
make SBINDIR=/usr/sbin install
install -vDm644 COPYING README* -t /usr/share/doc/iproute2-6.18.0 #docs

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


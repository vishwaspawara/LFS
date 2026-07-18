#!/bin/bash

# data for network services and protocols

set -euo pipefail

PACKAGE="iana-etc-20260202"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# copy the files to /etc

cp -v services protocols /etc

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

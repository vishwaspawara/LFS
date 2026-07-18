#!/bin/bash

set -euo pipefail

PACKAGE="pearl-5.42.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# Configure
sh Configure -des \
             -D prefix=/usr \
             -D vendorprefix=/usr \
             -D useshrplib \
             -D privlib=/usr/lib/perl5/5.42/core_perl \
             -D archlib=/usr/lib/perl5/5.42/core_perl \
             -D sitelib=/usr/lib/perl5/5.42/site_perl \
             -D sitearch=/usr/lib/perl5/5.42/site_perl \
             -D vendorlib=/usr/lib/perl5/5.42/vendor_perl \
             -D vendorarch=/usr/lib/perl5/5.42/vendor_perl

# Build
make

# Install
make install


# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PCKAGE installed successfully."

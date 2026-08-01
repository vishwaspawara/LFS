#!/bin/bash

# package contains programs for basic networking - such as ping,hostname,fpt,etc

set -euo pipefail

PACKAGE="inetutils-2.7"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# make the package build with gcc-14.1 or later
sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c

# configure 
./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

# compile 
make 

# test 
make check

# install and move program to proper location
make install
mv -v /usr/{,s}bin/ifconfig

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

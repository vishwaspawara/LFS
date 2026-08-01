#!/bin/bash

#general purpoes scripting language (tickle)

set -euo pipefail

PACKAGE="tcl-8.6.17"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# set the variable
SRCDIR=$(pwd)
cd unix

# configure and disable rpath hardcodding into binary executable
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --disable-rpath

# compile 
make 

# removing reference to build dir from configuration file and replace them with install dir
sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.12|/usr/lib/tdbc1.1.12|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.12/generic|/usr/include|"     \
    -e "s|$SRCDIR/pkgs/tdbc1.1.12/library|/usr/lib/tcl8.6|"  \
    -e "s|$SRCDIR/pkgs/tdbc1.1.12|/usr/include|"             \
    -i pkgs/tdbc1.1.12/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.3.4|/usr/lib/itcl4.3.4|" \
    -e "s|$SRCDIR/pkgs/itcl4.3.4/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.3.4|/usr/include|"            \
    -i pkgs/itcl4.3.4/itclConfig.sh

unset SRCDIR

# test
# using POSIX lacale with UTF-8 encodding
LC_ALL=C.UTF-8 make test

# install
make install
chmod 644 /usr/lib/libtclstub8.6.a
chmod -v u+w /usr/lib/libtcl8.6.so #making writable to remove debugging symbols later
make install-private-headers #next package requires these

ln -sfv tclsh8.6 /usr/bin/tclsh #necessary symlink
mv -v /usr/share/man/man3/{Thread,Tcl_Thread}.3 #rename as it conflicts with Perl man page

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

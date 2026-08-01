#!/bin/bash

# basic utility programs needed by every operating system
# cat, chown, chroot, cp, dd, cut, and many more

set -euo pipefail

PACKAGE="coreutils-9.10"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# patch to fix internationalization related bugs
patch -Np1 -i ../coreutils-9.10-i18n-1.patch

# configure 
autoreconf -fv
automake -af
FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr

# compile 
make 

# test 
make NON_ROOT_USERNAME=tester check-root
groupadd -g 102 dummy -U tester
chown -R tester .
su tester -c "PATH=$PATH make -k RUN_EXPENSIVE_TESTS=yes check" < /dev/null
groupdel dummy

# install
make install

# move programs to location specified by the FHS
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."
8.61-coreutils-9.10.sh

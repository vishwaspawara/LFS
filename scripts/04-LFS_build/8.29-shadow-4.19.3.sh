#!/bin/bash

#contains programs for handling passwords

set -euo pipefail

PACKAGE="shadow-4.19.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# disable installaton of groups as they were installed in corutils
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

# use yescrypt, use /var/mail instead of obsolete spool and remove bin, sbin from path
sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:'                   \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
    -i etc/login.defs

# create file before its location is hardcoded
touch /usr/bin/passwd

# configure 
./configure --sysconfdir=/etc   \
            --disable-static    \
            --with-{b,yes}crypt \
            --without-libbsd    \
            --disable-logind    \
            --with-group-name-max-length=32

# compile 
make 

# install
make exec_prefix=/usr install
make -C man install-man

#
# CONFIGURATION 
#
# enable shadowe password
pwconv

# enable shadowe group password
grpconv

# to change default parameter create following file must be created
mkdir -p /etc/default
useradd -D --gid 999

# I'm disabling mailboc creation of each new user
sed -i '/MAIL/s/yes/no/' /etc/default/useradd


#
# ROOT Password - follow through instructions
#
passwd root

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

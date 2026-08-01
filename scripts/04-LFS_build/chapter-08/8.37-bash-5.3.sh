#!/bin/bash

#bourne-again shell

set -euo pipefail

PACKAGE="bash-5.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# configure 
/configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.3

# compile 
make 

# test as non root user
# using Tcl expect shell
# script - do not timeout 
# spawn the terminal owned by tester and execute tests
# run till tests are completed
# assign 4th output to 'value' veriable
# exit with the 'value'
chown -R tester .
LC_ALL=C.UTF-8 su -s /usr/bin/expect tester << "EOF"
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

# install
make install

# run newly compiled bash program replacing the current
exec /usr/bin/bash --login

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

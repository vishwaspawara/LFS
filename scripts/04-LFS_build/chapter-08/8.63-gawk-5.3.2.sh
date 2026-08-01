#!/bin/bash

# awk and gawk

set -euo pipefail

PACKAGE="gawk-5.3.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# making sure unnecessary files are not gettting installed.
sed -i 's/extras//' Makefile.in

# configure 
./configure --prefix=/usr        \
            --sysconfdir=/etc

# compile 
make 

# test 
chown -R tester .
su tester -c "PATH=$PATH make check"

# install before that remove existing hardlink 
rm -f /usr/bin/gawk-5.3.2
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1 #create link
install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} -t /usr/share/doc/gawk-5.3.2 #documentation

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


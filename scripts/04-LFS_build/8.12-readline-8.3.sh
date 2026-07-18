#!/bin/bash

#set of libraries providing commandlien editing and history capabilities.

set -euo pipefail

PACKAGE="readline-8.3"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# reinstalling move the old libraries but this could trigger linking bug, to avoid 
sed -i '/MV.*old/d' Makefile.in 	#delete
sed -i '/{OLDSUFF}/c:' support/shlib-install #replace matching line with :

# rpath may cuase unwanted issues so replace it with nothing
sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

# small patch
# first append after line 270
#   else
#     chars_avail = 1;
# insert before line 288
#     result = -1
#  last line instructs create duplicate of input.c as input.c.orig and then edit input.c inplace
sed -e '270a\
     else\
       chars_avail = 1;'      \
    -e '288i\   result = -1;' \
    -i.orig input.c

# configure
./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.3

# compile 
make SHLIB_LIBS="-lncursesw"

# install
make install

# install documentation (optional)
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.3

# Cleanu
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

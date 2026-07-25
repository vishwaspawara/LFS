#!/bin/bash

# message bus system a way for application to talk to one another

set -euo pipefail

PACKAGE="dbus-1.16.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build in separate build dir
mkdir build
cd    build

# configure 
meson setup --prefix=/usr --buildtype=release --wrap-mode=nofallback ..

# compile 
ninja

# test 
ninja test

# install
make install

# create symlink so both dbus and systemd can be on the same machine
ln -sfv /etc/machine-id /var/lib/dbus

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


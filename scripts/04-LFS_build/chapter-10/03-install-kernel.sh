#!/bin/bash

#run as root

set -oue pipefail

PACKAGE="linux-6.18.10"

cd "/sources"

cd $PACKAGE


# compile 
make 

# install
make modules_install
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.18.10-lfs-13.0-systemd
cp -iv System.map            /boot/System.map-6.18.10
cp -iv .config               /boot/config-6.18.10
cp -r Documentation -T       /usr/share/doc/linux-6.18.10

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


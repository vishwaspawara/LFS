#!/bin/bash

# this package contains programs related to startup, running and shotdown of THE system

set -euo pipefail

PACKAGE="systemd-256.1"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# remove unneeded groups
sed -e 's/GROUP="render"/GROUP="video"/' \
    -e 's/GROUP="sgx", //'               \
    -i rules.d/50-udev-default.rules.in

# build in separate build dir
mkdir -p build
cd build

# configure 
meson setup ..                \
      --prefix=/usr           \
      --buildtype=release     \
      -D default-dnssec=no    \
      -D firstboot=false      \
      -D install-tests=false  \
      -D ldconfig=false       \
      -D sysusers=false       \
      -D rpmmacrosdir=no      \
      -D homed=disabled       \
      -D man=disabled         \
      -D mode=release         \
      -D pamconfdir=no        \
      -D dev-kvm-mode=0660    \
      -D nobody-group=nogroup \
      -D sysupdate=disabled   \
      -D ukify=disabled       \
      -D docdir=/usr/share/doc/systemd-259.1

# compile 
ninja

# test after creating necessary file
echo 'NAME="Linux From Scratch"' > /etc/os-release
unshare -m ninja test

# install
ninja install
tar -xf ../../systemd-man-pages-259.1.tar.xz \
    --no-same-owner --strip-components=1     \
    -C /usr/share/man

# create /etc/machine-id file for systemd-journald
systemd-machine-id-setup

# setup basic target structure
systemctl preset-all

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


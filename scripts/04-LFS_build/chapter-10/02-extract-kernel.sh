#!/bin/bash

# run as root
# refere the readme for configuration

set -oue pipefail

PACKAGE="linux-6.18.10"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# make sure kernel tree is clean
make mrproper

# configure 
make menuconfig

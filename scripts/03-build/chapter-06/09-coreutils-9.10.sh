#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

# Extract source
tar -xf coreutils-9.10.tar.xz
cd coreutils-9.10

# Configure
./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)" \
    --enable-install-program=hostname \
    --enable-no-install-program=kill,uptime

# Build
make

# Install
make DESTDIR="$LFS" install

# Move chroot to /usr/sbin (FHS compliance)
mv -v "$LFS/usr/bin/chroot" \
      "$LFS/usr/sbin"

# Move its man page to section 8 (System Administration Commands)
mkdir -pv "$LFS/usr/share/man/man8"

mv -v "$LFS/usr/share/man/man1/chroot.1" \
      "$LFS/usr/share/man/man8/chroot.8"

sed -i 's/"1"/"8"/' \
    "$LFS/usr/share/man/man8/chroot.8"

# Cleanup
cd "$LFS/sources"
rm -rf coreutils-9.10

echo "Coreutils installed successfully."

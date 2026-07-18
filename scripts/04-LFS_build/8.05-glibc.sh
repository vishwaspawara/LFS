#!/bin/bash

set -euo pipefail

PACKAGE="glibc-2.43"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# patch for fhs complient locations to store programs
patch -Np1 -i ../glibc-fhs-1.patch

# build in diff dir
mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

# configure
../configure --prefix=/usr                   \
             --disable-werror                \
             --disable-nscd                  \
             libc_cv_slibdir=/usr/lib        \
             --enable-stack-protector=strong \
             --enable-kernel=5.4
# make
make

# test
make check

# create to prevent future error while installing glibc
touch /etc/ld.so.conf

# skip outdated sanity checks for moder glibc configuration
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

# install
make install

# fix hardcoded path to excutable loader in ldd script
sed '/RTLDLIST=/s@/usr@@g' -i /usr/bin/ldd

# install locales 
make localedata/install-locale

# add nsswitch.conf
cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files systemd
group: files systemd
shadow: files systemd

hosts: mymachines resolve [!UNAVAIL=return] files myhostname dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

# add timezone data (do not change anything local time will set later)

tar -xf ../../tzdata2025c.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward; do
    zic -L /dev/null   -d $ZONEINFO       ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix ${tz}
    zic -L leapseconds -d $ZONEINFO/right ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO tz

# determine local time zone, not needed if you already know the local timezone
echo "for local time settings:"
echo "select int value representing the correct option"

tzselect

# from the output above create /etc/localtime file (Asia/Kolkata was found by obove command)
ln -sfv /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

# configure dynamic loader - /lib/ld-linux-so.2 searches through libraries needed by programmer when they run
cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

# adding searching capabilities for the dynamic loader
cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv /etc/ld.so.conf.d #creating the dir specified

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

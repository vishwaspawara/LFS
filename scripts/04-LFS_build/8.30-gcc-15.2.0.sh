#!/bin/bash

#we all know what this is 

set -euo pipefail

PACKAGE="gcc-15.2.0"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# fix required by glibc-2.43 and later
sed -i 's/char [*]q/const &/' libgomp/affinity-fmt.c

# need to override dir name from lib64 to lib
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

# copile in build dir
mkdir -v build
cd build

# configure 
# LD=ld forces to use ld program installed by binutils 
# bootstrap disabled not needed since not cross compilation
# diable 'fixes' which could damage proper lfs
../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --enable-host-pie        \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib

# compile 
make 

# setting no limit stack -usually default on new systems but no harm in setting it mannually
ulimit -s -H unlimited

# removing know test failure
sed -e '/cpython/d' -i ../gcc/testsuite/gcc.dg/plugin/plugin.exp

# test (as non root user but do not stop if test fails)
chown -R tester .
su tester -c "PATH=$PATH make -k check"

# extract the summary to compare with expected fail and nonnegotiable pass
../contrib/test_summary

# install
make install

# change ownership back to root
chown -v -R root:root \
    /usr/lib/gcc/$(gcc -dumpmachine)/15.2.0/include{,-fixed}

# create symlinkk required by FHS
ln -svr /usr/bin/cpp /usr/lib

# creating symlink to cc and gcc manpage
ln -sv gcc.1 /usr/share/man/man1/cc.1

# enable building programs with link time optimization
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/15.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/

# check compiling and linking works as expected
echo 'int main(){}' | cc -x c - -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
echo 'expected output:'
echo '[Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]'

# check we're setup to use correct start files
grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
echo 'expected output:'
echo '/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/Scrt1.o succeeded'
echo '/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/crti.o succeeded'
echo '/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/../../../../lib/crtn.o succeeded'

# confirm compiler is searching correct header files
grep -B4 '^ /usr/include' dummy.log
echo 'expected output:'
echo '#include <...> search starts here:'
echo '/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/include'
echo '/usr/local/include'
echo '/usr/lib/gcc/x86_64-pc-linux-gnu/15.2.0/include-fixed'
echo '/usr/include'

# confirm new linker is used with correct search paths
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
echo 'expected output:'
echo 'SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib64")'
echo 'SEARCH_DIR("/usr/local/lib64")'
echo 'SEARCH_DIR("/lib64")'
echo 'SEARCH_DIR("/usr/lib64")'
echo 'SEARCH_DIR("/usr/x86_64-pc-linux-gnu/lib")'
echo 'SEARCH_DIR("/usr/local/lib")'
echo 'SEARCH_DIR("/lib")'
echo 'SEARCH_DIR("/usr/lib");'

# make sure correct libc is being used
grep "/lib.*/libc.so.6 " dummy.log
echo 'expected output:'
echo 'attempt to open /usr/lib/libc.so.6 succeeded'

# make sure dynamic linker is using correct linker
grep found dummy.log
echo 'expected output:'
echo 'found ld-linux-x86-64.so.2 at /usr/lib/ld-linux-x86-64.so.2'

# cleanup testfiles
rm -v a.out dummy.log

# move misplaced files
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

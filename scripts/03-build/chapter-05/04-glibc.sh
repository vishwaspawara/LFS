#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"
: "${LFS_TGT:?LFS_TGT is not set}"

cd "$LFS/sources"

tar -xf glibc-2.43.tar.xz
cd glibc-2.43

# Create symlink for Linux Standard Base (LSB)
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

# patch for File Hierarchy System (FHS) structure - every program should store complient to FHS
patch -Np1 -i ../glibc-fhs-1.patch

# build in dedicated build dir as recommended
mkdir -v build
cd build

# Install ldconfig and sln into /usr/sbin
echo "rootsbindir=/usr/sbin" > configparms

# Configure
../configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(../scripts/config.guess)" \
    --disable-nscd \
    libc_cv_slibdir=/usr/lib \
    --enable-kernel=5.10

# Build
make

# Install
make DESTDIR="$LFS" install

# Fix hard coded path to the executable loader in the ldd script
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd

echo "cross toolchain is in place"

# Test
echo "testing compiling and linking will work as expected."
echo "expected output"
echo "[Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]"
echo "actual output:"

echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

echo "testing if correct start files"
echo "expected output:"
echo "/mnt/lfs/lib/../lib/Scrt1.o succeeded"
echo "/mnt/lfs/lib/../lib/crti.o succeeded"
echo "/mnt/lfs/lib/../lib/crtn.o succeeded"
echo "actual output:"

grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log

echo "testing if compiler is searching for correct header files"
echo "expected output:"
echo "#include <...> search starts here:"
echo " /mnt/lfs/tools/lib/gcc/x86_64-lfs-linux-gnu/15.2.0/include"
echo " /mnt/lfs/tools/lib/gcc/x86_64-lfs-linux-gnu/15.2.0/include-fixed"
echo " /mnt/lfs/usr/include"
echo "actual output:"

grep -B3 "^ $LFS/usr/include" dummy.log

echo "testing if new linker is being used with the correct search paths"
echo "expected output:"
echo 'SEARCH_DIR("=/mnt/lfs/tools/x86_64-lfs-linux-gnu/lib64")'
echo 'SEARCH_DIR("=/usr/local/lib64")'
echo 'SEARCH_DIR("=/lib64")'
echo 'SEARCH_DIR("=/usr/lib64")'
echo 'SEARCH_DIR("=/mnt/lfs/tools/x86_64-lfs-linux-gnu/lib")'
echo 'SEARCH_DIR("=/usr/local/lib")'
echo 'SEARCH_DIR("=/lib")'
echo 'SEARCH_DIR("=/usr/lib");'
echo "actual output:"

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

echo "testing if we're using correct libc"
echo "expted output:"
echo "attempt to open /mnt/lfs/usr/lib/libc.so.6 succeeded"
echo "actual output:"
grep "/lib.*/libc.so.6 " dummy.log

echo "make sure gcc is using correct dynamic linker"
echo "expected output:"
echo "found ld-linux-x86-64.so.2 at /mnt/lfs/usr/lib/ld-linux-x86-64.so.2"
echo "actual output:"
grep found dummy.log

# Cleanup
rm -v a.out dummy.log

cd "$LFS/sources"
rm -rf glibc-2.43

echo "Glibc installed."

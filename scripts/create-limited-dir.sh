#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"


sudo mkdir -pv $LFS/{etc,var} 
sudo mkdir -pv $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do 
	ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
	x86_64) sudo mkdir -pv $LFS/lib64 ;;
esac

sudo mkdir -pv $LFS/tools

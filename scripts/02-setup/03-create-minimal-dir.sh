#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

mkdir -pv \
    "$LFS"/{etc,var} \
    "$LFS"/usr/{bin,lib,sbin}

for dir in bin lib sbin; do
    ln -sv "usr/$dir" "$LFS/$dir"
done

case "$(uname -m)" in
    x86_64)
        mkdir -pv "$LFS/lib64"
        ;;
esac

mkdir -pv "$LFS/tools"



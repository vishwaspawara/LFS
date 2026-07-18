#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

[[ "$LFS" == "/mnt/lfs" ]] || {
    echo "Unexpected LFS path: $LFS"
    exit 1
}

for dir in \
    "$LFS" \
    "$LFS/dev" \
    "$LFS/dev/pts" \
    "$LFS/proc" \
    "$LFS/sys" \
    "$LFS/run"
do
    mountpoint -q "$dir" || {
        echo "Missing mount: $dir"
        exit 1
    }
done

chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j$(nproc)" \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login

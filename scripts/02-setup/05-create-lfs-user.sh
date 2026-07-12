#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

sudo groupadd -f lfs

if ! id lfs >/dev/null 2>&1; then
    sudo useradd \
        -s /bin/bash \
        -g lfs \
        -m \
        -k /dev/null \
        lfs

    sudo passwd lfs
fi

sudo chown -v lfs \
    "$LFS"/usr{,/*} \
    "$LFS"/var \
    "$LFS"/etc \
    "$LFS"/tools \
    "$LFS"/lib64

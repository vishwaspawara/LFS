#!/bin/bash

set -euo pipefail

: "${LFS:?LFS environment variable is not set}"

BASE_URL="https://www.linuxfromscratch.org/lfs/downloads/stable-systemd"
WGET_LIST="$LFS/sources/wget-list"

mkdir -pv "$LFS/sources"

echo "Downloading wget-list..."
wget \
    --continue \
    --directory-prefix="$LFS/sources" \
    "$BASE_URL/wget-list"

echo "Downloading LFS packages..."
wget \
    --input-file="$WGET_LIST" \
    --continue \
    --directory-prefix="$LFS/sources"

echo "Download complete."


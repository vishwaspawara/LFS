#!/bin/bash

set -euo pipefail

: "${LFS:?LFS is not set}"

mkdir -pv "$LFS/sources"
chmod -v a+wt "$LFS/sources"

echo "Sources directory ready."

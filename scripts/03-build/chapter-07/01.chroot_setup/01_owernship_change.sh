#!/bin/bash

set -euo pipefail
:"${LFS:?LFS is not set}"


chown --from lfs -R root:root $LFS/{usr,var,etc,tools}
case $(uname -m) in
  x86_64) chown --from lfs -R root:root $LFS/lib64 ;;
esac

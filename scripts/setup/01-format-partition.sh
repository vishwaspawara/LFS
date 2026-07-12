#!/bin/bash

set -euo pipefail

DEVICE=/dev/nvme0n1p3
LABEL=lfs

sudo mkfs.ext4 "$DEVICE"
sudo e2label "$DEVICE" "$LABEL"

echo "Partition formatted and labeled."

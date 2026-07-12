#!/bin/bash

set -euo pipefail

PACKAGE_LIST="package-list.txt"

if [[ ! -f "$PACKAGE_LIST" ]]; then
    echo "Error: $PACKAGE_LIST not found."
    exit 1
fi

echo "Updating package index..."
sudo apt update

echo "Installing required packages..."
sudo xargs -a "$PACKAGE_LIST" apt install -y

echo "Running LFS host verification..."
./scripts/version-check.sh

echo "Done."

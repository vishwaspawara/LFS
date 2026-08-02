#!/bin/bash

set -oue pipefail

# give id and provide the dir
grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=LFS

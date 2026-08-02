#!/bin/bash

set -oue pipefail

#kerner version and image
VERSION="6.18.10"
IMAGE="vmlinuz-${VERSION}-lfs-13.0-systemd"


[[ -f "/boot/${IMAGE}" ]] \
    && pass "Kernel image found" \
    || fail "Missing /boot/${IMAGE}"

[[ -f "/boot/System.map-${VERSION}" ]] \
    && pass "System.map found" \
    || fail "Missing System.map"

[[ -f "/boot/config-${VERSION}" ]] \
    && pass "Kernel config found" \
    || fail "Missing kernel config"


[[ -d "/lib/modules/${VERSION}" ]] \
    && pass "Kernel modules installed" \
    || fail "Kernel modules missing"


mountpoint -q /boot/efi \
    && pass "EFI partition mounted" \
    || fail "/boot/efi is not mounted"

[[ -d /boot/efi/EFI ]] \
    && pass "EFI directory exists" \
    || fail "EFI directory missing"


mountpoint -q /sys/firmware/efi/efivars \
    && pass "efivarfs mounted" \
    || fail "efivarfs not mounted"


command -v grub-install >/dev/null \
    && pass "grub-install found" \
    || fail "grub-install missing"

command -v grub-mkconfig >/dev/null \
    && pass "grub-mkconfig found" \
    || fail "grub-mkconfig missing"

command -v efibootmgr >/dev/null \
    && pass "efibootmgr found" \
    || fail "efibootmgr missing"


[[ -d /usr/lib/grub/x86_64-efi ]] \
    && pass "UEFI GRUB modules present" \
    || fail "x86_64-efi GRUB modules missing"


efibootmgr || warn "Unable to read EFI boot entries"


#!/bin/bash

echo 13.0-systemd > /etc/lfs-release

# Linux Standard Base
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="13.0-systemd"
DISTRIB_CODENAME="vshws"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

# contains same info as above just used by systemd and graphical desktop environment
at > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="13.0-systemd"
ID=lfs
PRETTY_NAME="Linux From Scratch 13.0-systemd"
VERSION_CODENAME="vshws"
HOME_URL="https://www.linuxfromscratch.org/lfs/"
RELEASE_TYPE="stable"
EOF


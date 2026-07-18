#!/bin/bash

set -oue pipefail
:"{$LFS:LFS not set}"

cd $LFS
rm -rf ./*
tar -xpf $HOME/lfs-temp-tools-13.0-systemd.tar.xz #or the path of tarball


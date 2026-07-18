#!/bin/bash


rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete #these could break BLFS
rm -rf /tools #this dir is also not needed as we already have everythin in lfs system


exit #exit the chroot to perform backup task

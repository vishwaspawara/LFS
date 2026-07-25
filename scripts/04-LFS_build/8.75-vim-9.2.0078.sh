#!/bin/bash

# my go to editor - even on terminal set -o vi :)

set -euo pipefail

PACKAGE="vim-9.2.0078"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# change default location of vimrc to /etc:
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

# configure 
./configure --prefix=/usr 

# compile 
make 

# test, remove tests containning wget/curl and redirect output to tmp
chown -R tester .
sed '/test_plugin_glvs/d' -i src/testdir/Make_all.mak
su tester -c "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" &> vim-test.log

# install
make install

# create symlink to vi and vim
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
ln -sv ../vim/vim92/doc /usr/share/doc/vim-9.2.0078 #doc

# configure vim I shall make changes to .vimrc in my own profile later
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."


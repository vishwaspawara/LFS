#!/bin/bash

# small build system focused on speed (it uses max possible processes in parallel)

set -euo pipefail

PACKAGE="ninja-1.13.2"

cd "/sources"

# Extract 
tar -xf "${PACKAGE}.tar.xz"
cd $PACKAGE

# build
python3 configure.py --bootstrap --verbose

# install
install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja

# Cleanup
cd "/sources"
rm -rf $PACKAGE

echo "$PACKAGE installed successfully."

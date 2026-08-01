#!/bin/bash

# this file is used to verify the shell, if shell is not listed switching to the same is not allowed.
#
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

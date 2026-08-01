#!/bin/bash


cat > /etc/systemd/network/10-eth-dhcp.network << "EOF"
[Match]
Name=wlp2s0

[Network]
DHCP=ipv4

[DHCPv4]
UseDomains=true
EOF

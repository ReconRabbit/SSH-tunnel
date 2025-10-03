#!/bin/bash

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Default policy: drop all forwarded traffic
iptables -P FORWARD DROP

# Allow established/related return traffic
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ONLY Germany -> Russia
iptables -A FORWARD -s 10.10.10.0/24 -d 200.53.76.0/24 -j ACCEPT

# Optional: keep INPUT open (or lock down if needed)
#iptables -P INPUT ACCEPT

# Execute the CMD from Dockerfile (sleep or sshd)
exec "$@"

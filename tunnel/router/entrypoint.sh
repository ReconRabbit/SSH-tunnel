#!/bin/bash
# Default: allow forwarding
iptables -P FORWARD ACCEPT

# Drop traffic coming from the Docker host (bridge) into russia_net
iptables -A INPUT -s 172.17.0.0/16 -d 10.20.20.0/24 -j DROP

# Start SSHD if you want router SSH, otherwise just sleep
exec /usr/sbin/sshd -D -e

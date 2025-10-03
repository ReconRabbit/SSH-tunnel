#!/bin/bash
set -euo pipefail

PREFIX="tunnel"

# Find containers whose IMAGE starts with the prefix
CONTAINERS=$(docker ps -a --format '{{.ID}} {{.Image}}' \
            | awk -v p="$PREFIX" '$2 ~ "^"p {print $1}')

if [[ -n "$CONTAINERS" ]]; then
    docker stop $CONTAINERS || true
    docker rm   $CONTAINERS
else
    echo "No containers found with image prefix '$PREFIX'."
fi

# Remove networks created by this project
NETWORKS=$(docker network ls --format '{{.ID}} {{.Name}}' \
           | awk -v p="$PREFIX" '$2 ~ "^"p {print $1}')

if [[ -n "$NETWORKS" ]]; then
    docker network rm $NETWORKS
else
    echo "No networks found with name prefix '$PREFIX'."
fi

# cleanup-tunnel.sh
# Removes all DOCKER-USER rules and logs for tunnel enforcement

echo "Cleaning up DOCKER-USER rules..."

# 1️⃣ Ensure DOCKER-USER exists
sudo iptables -N DOCKER-USER 2>/dev/null || echo "DOCKER-USER already exists"

# 2️⃣ Flush all DOCKER-USER rules
sudo iptables -F DOCKER-USER

# 3️⃣ Optional: leave chain in default state (no need to set policy, it's user-defined)
echo "DOCKER-USER rules flushed."

# 4️⃣ Verify
sudo iptables -L DOCKER-USER -n

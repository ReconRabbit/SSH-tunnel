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
 

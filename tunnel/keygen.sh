#!/usr/bin/env bash
set -euo pipefail

# === Config ===
SSH_KEY_PATH="$HOME/.ssh/tunnel_key"
PUB_KEY_PATH="${SSH_KEY_PATH}.pub"
CONTAINER_NAME="${1:-germany_jump}"  # default container name
CONTAINER_ROOT_SSH="/root/.ssh"
AUTHORIZED_KEYS_TMP="/tmp/authorized_keys_for_container"

# === 1) Generate new SSH key pair locally ===
if [[ -f "$SSH_KEY_PATH" || -f "$PUB_KEY_PATH" ]]; then
    echo "Removing existing SSH key pair..."
    rm -f "$SSH_KEY_PATH" "$PUB_KEY_PATH"
fi

echo "Generating new SSH key pair at $SSH_KEY_PATH..."
ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -q -N ""
echo "✅ New SSH key pair generated."

# === 2) Prepare authorized_keys temporarily ===
cat "$PUB_KEY_PATH" > "$AUTHORIZED_KEYS_TMP"
chmod 600 "$AUTHORIZED_KEYS_TMP"

# === 3) Check container is running ===
if ! docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME\$"; then
    echo "⚠ Container '$CONTAINER_NAME' is not running. Start it first:"
    echo "    docker compose up -d $CONTAINER_NAME"
    exit 1
fi

# === 4) Copy authorized_keys into container and fix perms ===
docker exec "$CONTAINER_NAME" mkdir -p "$CONTAINER_ROOT_SSH"
docker cp "$AUTHORIZED_KEYS_TMP" "$CONTAINER_NAME":"$CONTAINER_ROOT_SSH"/authorized_keys
docker exec "$CONTAINER_NAME" chown -R root:root "$CONTAINER_ROOT_SSH"
docker exec "$CONTAINER_NAME" chmod 700 "$CONTAINER_ROOT_SSH"
docker exec "$CONTAINER_NAME" chmod 600 "$CONTAINER_ROOT_SSH/authorized_keys"

# Cleanup
rm -f "$AUTHORIZED_KEYS_TMP"

echo
echo "✅ authorized_keys installed in container '$CONTAINER_NAME'"
echo
echo "➡ SSH into Germany container:"
echo "    ssh -i $SSH_KEY_PATH root@localhost -p 2222"

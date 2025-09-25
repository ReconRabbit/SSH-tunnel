#!/bin/bash
set -euo pipefail

# === Config ===
SSH_KEY_PATH="$HOME/.ssh/tunnel_key"           # Host private key
PUB_KEY_PATH="${SSH_KEY_PATH}.pub"             # Host public key
CONTAINER_KEYS_DIR="$PWD/germany"              # Directory that will be mounted into the container
AUTHORIZED_KEYS_FILE="$CONTAINER_KEYS_DIR/authorized_keys"

# === Remove old keys if present ===
if [[ -f "$SSH_KEY_PATH" || -f "$PUB_KEY_PATH" ]]; then
    echo "Removing existing SSH key pair..."
    rm -f "$SSH_KEY_PATH" "$PUB_KEY_PATH"
fi

# === Generate fresh key pair ===
echo "Generating new SSH key pair at $SSH_KEY_PATH..."
ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -q -N ""
echo "✅ New SSH key pair generated."

# === Prepare docker bind mount folder ===
mkdir -p "$CONTAINER_KEYS_DIR"

# Copy public key into germany/authorized_keys
cp "$PUB_KEY_PATH" "$AUTHORIZED_KEYS_FILE"

# Correct permissions for OpenSSH inside the container
chmod 700 "$CONTAINER_KEYS_DIR"
chmod 600 "$AUTHORIZED_KEYS_FILE"

echo
echo "✅ Public key copied to: $AUTHORIZED_KEYS_FILE"
echo "✅ Private key saved at: $SSH_KEY_PATH"
echo
echo "➡️  Use this in docker-compose or docker run:"
echo "    -v \"\$PWD/germany/authorized_keys:/root/.ssh/authorized_keys:ro\""
echo
echo "➡️  Connect with:"
echo "    ssh -i $SSH_KEY_PATH -p <exposed_port> root@localhost"
 

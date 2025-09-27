#!/usr/bin/env bash
set -euo pipefail

# Usage: scripts/docker-deploy.sh <PUBLIC_IP> <COMPOSE_FILE> [SSH_KEY_PATH] [USER]

HOST_IP=${1:-}
COMPOSE_FILE=${2:-}
SSH_KEY_PATH=${3:-$HOME/.ssh/oci_arm_key}
SSH_USER=${4:-ubuntu}

if [[ -z "$HOST_IP" || -z "$COMPOSE_FILE" ]]; then
  echo "Usage: $0 <PUBLIC_IP> <COMPOSE_FILE> [SSH_KEY_PATH] [USER]"
  exit 1
fi

if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "Compose file not found: $COMPOSE_FILE"
  exit 1
fi

REMOTE_DIR="~/app"

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$SSH_USER@$HOST_IP" "mkdir -p $REMOTE_DIR"
scp -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$COMPOSE_FILE" "$SSH_USER@$HOST_IP:$REMOTE_DIR/docker-compose.yml"

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$SSH_USER@$HOST_IP" <<'EOSSH'
set -euxo pipefail
cd ~/app
# Prefer docker compose plugin; fallback to docker-compose if present
if docker compose version >/dev/null 2>&1; then
  docker compose pull
  docker compose up -d
elif command -v docker-compose >/dev/null 2>&1; then
  docker-compose pull
  docker-compose up -d
else
  echo "Docker Compose is not installed on remote host." >&2
  exit 1
fi
EOSSH

echo "Docker compose deployment completed to $HOST_IP"


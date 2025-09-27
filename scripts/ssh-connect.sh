#!/usr/bin/env bash
set -euo pipefail

# Attempts to read public_ip from Terraform outputs if not provided.

ENV_DIR=${ENV:-dev}
HOST_IP=${1:-}
SSH_KEY_PATH=${SSH_KEY_PATH:-$HOME/.ssh/oci_arm_key}
SSH_USER=${SSH_USER:-ubuntu}

if [[ -z "$HOST_IP" ]]; then
  cd "$(dirname "$0")/../environments/${ENV_DIR}"
  HOST_IP=$(terraform output -raw public_ip 2>/dev/null || true)
fi

if [[ -z "$HOST_IP" ]]; then
  echo "Usage: $0 <PUBLIC_IP> (or ensure 'terraform output -raw public_ip' works)"
  exit 1
fi

echo "Connecting to $SSH_USER@$HOST_IP ..."
exec ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$SSH_USER@$HOST_IP"


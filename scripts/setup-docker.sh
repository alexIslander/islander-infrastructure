#!/usr/bin/env bash
set -euo pipefail

# Usage: scripts/setup-docker.sh <PUBLIC_IP> [SSH_KEY_PATH] [USER]
# Defaults: SSH_KEY_PATH=~/.ssh/oci_arm_key USER=ubuntu

HOST_IP=${1:-}
SSH_KEY_PATH=${2:-$HOME/.ssh/oci_arm_key}
SSH_USER=${3:-ubuntu}

if [[ -z "$HOST_IP" ]]; then
  echo "Usage: $0 <PUBLIC_IP> [SSH_KEY_PATH] [USER]"
  exit 1
fi

ssh -o StrictHostKeyChecking=no -i "$SSH_KEY_PATH" "$SSH_USER@$HOST_IP" <<'EOSSH'
set -euxo pipefail
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER || true
sudo systemctl enable docker
sudo systemctl start docker
docker --version
docker compose version || docker-compose --version || true
EOSSH

echo "Docker setup completed on $HOST_IP"


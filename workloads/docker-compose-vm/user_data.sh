#!/bin/bash
# Cloud-init script to prepare Docker and Docker Compose on Ubuntu

set -euxo pipefail

apt-get update -y
apt-get upgrade -y

# Install dependencies
apt-get install -y ca-certificates curl gnupg lsb-release

# Setup Docker repository
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add ubuntu user to docker group if present
if id "ubuntu" &>/dev/null; then
  usermod -aG docker ubuntu
fi

systemctl enable docker
systemctl start docker

echo "Docker installed successfully." | tee /var/log/docker-install.log


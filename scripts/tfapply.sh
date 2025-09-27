#!/usr/bin/env bash
set -euo pipefail

ENV_DIR=${ENV:-dev}

cd "$(dirname "$0")/../environments/${ENV_DIR}"

if [[ ! -f tfplan ]]; then
  echo "No tfplan found. Running 'terraform plan' first..."
  terraform init -input=false
  terraform plan -out=tfplan
fi

echo "Applying Terraform plan..."
terraform apply -auto-approve tfplan


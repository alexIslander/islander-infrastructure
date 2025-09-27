#!/usr/bin/env bash
set -euo pipefail

ENV_DIR=${ENV:-dev}

cd "$(dirname "$0")/../environments/${ENV_DIR}"

echo "Initializing Terraform in environments/${ENV_DIR}..."
terraform init -input=false

echo "Planning Terraform..."
terraform plan -out=tfplan
echo "Plan saved to environments/${ENV_DIR}/tfplan"


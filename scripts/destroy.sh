#!/usr/bin/env bash
set -euo pipefail

ENV_DIR=${ENV:-dev}

cd "$(dirname "$0")/../environments/${ENV_DIR}"

echo "Destroying Terraform-managed resources in ${ENV_DIR}..."
terraform init -input=false
terraform destroy -auto-approve


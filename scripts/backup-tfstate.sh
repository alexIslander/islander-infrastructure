#!/usr/bin/env bash
set -euo pipefail

ENV_DIR=${ENV:-dev}
TS=$(date +%Y%m%d-%H%M%S)
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

STATE_DIR="$ROOT_DIR/environments/${ENV_DIR}"
BACKUP_DIR="$ROOT_DIR/backups/${ENV_DIR}"

mkdir -p "$BACKUP_DIR"

if [[ -f "$STATE_DIR/terraform.tfstate" ]]; then
  cp "$STATE_DIR/terraform.tfstate" "$BACKUP_DIR/terraform.tfstate.$TS"
  echo "Backed up local state to $BACKUP_DIR/terraform.tfstate.$TS"
else
  echo "No local state file found (using remote state or not initialized)."
fi


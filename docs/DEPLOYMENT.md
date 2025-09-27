# Deployment Guide

- Prerequisites: OCI account, API keys, Terraform Cloud workspace, GitHub secrets.
- Local deploy:
  - Copy `environments/dev/terraform.tfvars.template` to `terraform.tfvars` and fill values.
  - Run: `./scripts/tfplan.sh` then `./scripts/tfapply.sh`.
- Terraform Cloud deploy:
  - Commit changes to `main` to trigger `Terraform Deploy` workflow.
  - Ensure secrets are configured (see SECRETS_MANAGEMENT.md).
- Access:
  - Get IP: `cd environments/dev && terraform output -raw public_ip`.
  - SSH: `./scripts/ssh-connect.sh`.
- Teardown: `./scripts/destroy.sh`.


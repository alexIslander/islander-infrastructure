# islander-infrastructure

Infrastructure as Code for OCI Free Tier using Terraform.

Contents:
- Modules: networking (VCN, subnets, IGW, routes, security list), compute (ARM A1 Flex), storage (block volume + attachment), security (NSG placeholder)
- Environments: dev (ready), staging/prod placeholders
- Workloads: docker-compose VM template
- Scripts: plan/apply/destroy, SSH helpers, Docker deploy
- CI/CD: GitHub Actions for validate + deploy

Prerequisites
- OCI account and API keys
- Terraform Cloud workspace and token (optional but recommended)
- SSH keypair for VM access

Getting Started
- Local: copy `environments/dev/terraform.tfvars.template` to `terraform.tfvars` and fill values, then run `./scripts/tfplan.sh` and `./scripts/tfapply.sh`.
- Cloud: configure GitHub secrets and push to `main` to trigger deploy. See `docs/SECRETS_MANAGEMENT.md` and `docs/DEPLOYMENT.md`.

Module Overview
- See `docs/ARCHITECTURE.md` for details of each module and how the workload composes them.

Deployment
- Step-by-step instructions in `docs/DEPLOYMENT.md`.

Security
- Guidance and best practices in `docs/SECURITY.md` and `docs/SECRETS_MANAGEMENT.md`.

Troubleshooting
- Ensure `ssh_public_key` variable contains the public key content (or use `file("~/.ssh/oci_arm_key.pub")` locally).
- If image lookup fails, adjust `image_operating_system` or `image_operating_system_version` in `modules/compute` variables.
- Validate auth by running a simple data source in `environments/dev` if needed (see plan’s Test OCI Authentication step).

# Architecture

- Provider: OCI with Terraform.
- Modules:
  - `networking`: VCN, public/private subnets, IGW, route table, security list.
  - `compute`: A1.Flex ARM instance with SSH key injection and cloud-init.
  - `storage`: Block volume creation + attachment; optional backup policy.
  - `security`: Placeholder for NSGs (future expansion).
- Workload:
  - `docker-compose-vm`: Composes networking, compute, storage for a Docker-ready VM.
- Environments:
  - `dev`: Root module that sources the workload.


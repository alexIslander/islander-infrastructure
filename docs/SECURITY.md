# Security Considerations

- Use Terraform Cloud for remote state and state locking.
- Store OCI credentials and SSH keys as GitHub Actions secrets or Terraform Cloud variables.
- Restrict SSH ingress (`ssh_ingress_cidr`) to trusted IPs only.
- Rotate API keys regularly; remove unused keys.
- Use separate compartments per environment when moving beyond dev.
- Consider Network Security Groups for finer-grained rules (see `modules/security`).


# Secrets Management

GitHub Secrets (repository level):
- `OCI_TENANCY_OCID`
- `OCI_USER_OCID`
- `OCI_FINGERPRINT`
- `OCI_PRIVATE_KEY` (base64-encoded private key PEM)
- `OCI_COMPARTMENT_ID`
- `SSH_PUBLIC_KEY` (public key content for instance access)
- `TF_CLOUD_TOKEN` (Terraform Cloud user token)

Terraform Cloud variables (workspace):
- Sensitive: `tenancy_ocid`, `user_ocid`, `fingerprint`, `private_key_path` (usually `~/.oci/oci_api_key.pem`), `compartment_id`
- Non-sensitive: `region`, `ssh_public_key`

Local development:
- Copy `.env.template` to `.env` and fill values.
- Do not commit `.env` or `.tfvars` files.


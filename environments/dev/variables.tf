variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "User OCID"
  type        = string
}

variable "fingerprint" {
  description = "API key fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to OCI API private key (local dev)"
  type        = string
}

variable "region" {
  description = "OCI region"
  type        = string
  default     = "us-ashburn-1"
}

variable "compartment_id" {
  description = "Compartment OCID for resources"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content to inject"
  type        = string
}

# Optional tuning
variable "instance_ocpus" {
  description = "Instance OCPUs"
  type        = number
  default     = 2
}

variable "instance_memory_gb" {
  description = "Instance memory in GB"
  type        = number
  default     = 12
}

variable "volume_size_gbs" {
  description = "Block volume size in GB"
  type        = number
  default     = 100
}


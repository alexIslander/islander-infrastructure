variable "tenancy_ocid" {
  description = "Tenancy OCID (for AD lookup)"
  type        = string
}

variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "vcn_cidr" {
  description = "VCN CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ssh_public_key" {
  description = "SSH public key content to inject"
  type        = string
}

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

variable "user_data" {
  description = "Optional user_data override; defaults to baked-in script"
  type        = string
  default     = null
  nullable    = true
}


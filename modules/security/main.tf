# Placeholder security module for future expansion.
# Example: Network Security Group for fine-grained rules.

variable "compartment_id" {
  description = "Compartment OCID"
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID"
  type        = string
}

variable "display_name" {
  description = "Display name for the NSG"
  type        = string
  default     = "islander-nsg"
}

resource "oci_core_network_security_group" "nsg" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
}

output "nsg_id" {
  value       = oci_core_network_security_group.nsg.id
  description = "Network Security Group OCID"
}


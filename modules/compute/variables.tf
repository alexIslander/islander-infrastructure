variable "tenancy_ocid" {
  description = "OCID of the tenancy (used to query availability domains)"
  type        = string
}

variable "compartment_id" {
  description = "OCID of the compartment where to create the instance"
  type        = string
}

variable "subnet_id" {
  description = "OCID of the subnet to attach the primary VNIC"
  type        = string
}

variable "instance_display_name" {
  description = "Display name for the instance"
  type        = string
  default     = "arm-instance"
}

variable "instance_ocpus" {
  description = "Number of OCPUs for the A1 Flex shape"
  type        = number
  default     = 2
}

variable "instance_memory_gb" {
  description = "Memory in GB for the A1 Flex shape"
  type        = number
  default     = 12
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the instance"
  type        = bool
  default     = true
}

variable "ssh_authorized_keys" {
  description = "SSH public key content to inject as authorized key"
  type        = string
}

variable "user_data" {
  description = "Cloud-init user_data script to run on first boot"
  type        = string
  default     = null
  nullable    = true
}

variable "image_operating_system" {
  description = "Operating system for the image search"
  type        = string
  default     = "Canonical Ubuntu"
}

variable "image_operating_system_version" {
  description = "Operating system version for the image search"
  type        = string
  default     = "22.04"
}


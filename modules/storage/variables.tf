variable "compartment_id" {
  description = "OCID of the compartment for the volume"
  type        = string
}

variable "availability_domain" {
  description = "Availability Domain name for the volume"
  type        = string
}

variable "instance_id" {
  description = "OCID of the instance to attach the volume to"
  type        = string
}

variable "volume_size_gbs" {
  description = "Size of the block volume in GB"
  type        = number
  default     = 100
}

variable "attachment_type" {
  description = "Attachment type: paravirtual or iscsi"
  type        = string
  default     = "paravirtual"
  validation {
    condition     = contains(["paravirtual", "iscsi"], var.attachment_type)
    error_message = "attachment_type must be 'paravirtual' or 'iscsi'"
  }
}

variable "display_name" {
  description = "Display name for the volume"
  type        = string
  default     = "data-volume"
}

variable "backup_policy_id" {
  description = "OCID of a backup policy to assign to the volume (optional)"
  type        = string
  default     = null
  nullable    = true
}


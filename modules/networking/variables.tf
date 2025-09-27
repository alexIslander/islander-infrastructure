variable "compartment_id" {
  description = "OCID of the compartment to create networking resources in"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed for SSH ingress"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allow_http_https" {
  description = "Whether to allow HTTP/HTTPS ingress"
  type        = bool
  default     = true
}

variable "docker_ports" {
  description = "List of extra TCP ports to allow for Dockerized apps"
  type        = list(number)
  default     = []
}


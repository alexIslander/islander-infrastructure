locals {
  default_user_data = trimspace(file("${path.module}/user_data.sh"))
  effective_user_data = var.user_data != null ? var.user_data : local.default_user_data
}

module "networking" {
  source             = "../../modules/networking"
  compartment_id     = var.compartment_id
  vcn_cidr           = var.vcn_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  ssh_ingress_cidr   = var.ssh_ingress_cidr
  allow_http_https   = true
  docker_ports       = []
}

module "compute" {
  source                = "../../modules/compute"
  tenancy_ocid          = var.tenancy_ocid
  compartment_id        = var.compartment_id
  subnet_id             = module.networking.public_subnet_id
  instance_display_name = "docker-compose-arm"
  instance_ocpus        = var.instance_ocpus
  instance_memory_gb    = var.instance_memory_gb
  assign_public_ip      = true
  ssh_authorized_keys   = var.ssh_public_key
  user_data             = local.effective_user_data
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

module "storage" {
  source              = "../../modules/storage"
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  instance_id         = module.compute.instance_id
  volume_size_gbs     = var.volume_size_gbs
  attachment_type     = "paravirtual"
}


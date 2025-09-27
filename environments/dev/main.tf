module "docker_compose_vm" {
  source           = "../../workloads/docker-compose-vm"
  tenancy_ocid     = var.tenancy_ocid
  compartment_id   = var.compartment_id
  ssh_public_key   = var.ssh_public_key
  instance_ocpus   = var.instance_ocpus
  instance_memory_gb = var.instance_memory_gb
  volume_size_gbs  = var.volume_size_gbs
}


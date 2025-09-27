output "public_ip" {
  description = "Public IP of the Docker Compose VM"
  value       = module.compute.public_ip
}

output "vcn_id" {
  description = "VCN OCID"
  value       = module.networking.vcn_id
}


output "instance_id" {
  description = "The OCID of the created instance"
  value       = oci_core_instance.arm_instance.id
}

output "public_ip" {
  description = "The public IP address of the instance (if assigned)"
  value       = try(data.oci_core_vnic.primary.public_ip_address, null)
}

output "private_ip" {
  description = "The private IP address of the instance"
  value       = try(data.oci_core_vnic.primary.private_ip_address, null)
}


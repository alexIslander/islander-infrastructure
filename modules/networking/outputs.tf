output "vcn_id" {
  description = "The OCID of the VCN"
  value       = oci_core_vcn.this.id
}

output "public_subnet_id" {
  description = "The OCID of the public subnet"
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "The OCID of the private subnet"
  value       = oci_core_subnet.private.id
}

output "public_security_list_id" {
  description = "The OCID of the public security list"
  value       = oci_core_security_list.public.id
}

output "public_route_table_id" {
  description = "The OCID of the public route table"
  value       = oci_core_route_table.public.id
}


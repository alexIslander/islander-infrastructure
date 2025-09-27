output "volume_id" {
  description = "The OCID of the created block volume"
  value       = oci_core_volume.this.id
}


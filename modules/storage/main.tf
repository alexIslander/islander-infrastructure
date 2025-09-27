resource "oci_core_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  size_in_gbs         = var.volume_size_gbs
}

resource "oci_core_volume_attachment" "this" {
  attach_type = var.attachment_type
  instance_id = var.instance_id
  volume_id   = oci_core_volume.this.id
}

resource "oci_core_volume_backup_policy_assignment" "assignment" {
  count     = var.backup_policy_id == null ? 0 : 1
  asset_id  = oci_core_volume.this.id
  policy_id = var.backup_policy_id
}


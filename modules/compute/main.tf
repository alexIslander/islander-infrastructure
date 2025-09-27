locals {
  metadata = var.user_data != null ? {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data           = base64encode(var.user_data)
  } : {
    ssh_authorized_keys = var.ssh_authorized_keys
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "ubuntu_arm" {
  compartment_id           = var.compartment_id
  operating_system         = var.image_operating_system
  operating_system_version = var.image_operating_system_version
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

resource "oci_core_instance" "arm_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = var.instance_display_name
  shape               = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_memory_gb
  }

  create_vnic_details {
    assign_public_ip = var.assign_public_ip
    subnet_id        = var.subnet_id
  }

  metadata = local.metadata

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_arm.images[0].id
  }
}

data "oci_core_vnic_attachments" "vnics" {
  compartment_id = var.compartment_id
  instance_id    = oci_core_instance.arm_instance.id
}

data "oci_core_vnic" "primary" {
  vnic_id = data.oci_core_vnic_attachments.vnics.vnic_attachments[0].vnic_id
}


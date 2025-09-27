locals {
  vcn_display_name   = "islander-vcn"
  vcn_dns_label      = "islandervcn"
  rt_display_name    = "islander-rt-public"
  igw_display_name   = "islander-igw"
  sl_display_name    = "islander-sl-public"
  subnet_public_name = "islander-subnet-public"
  subnet_public_dns  = "public"
  subnet_priv_name   = "islander-subnet-private"
  subnet_priv_dns    = "private"
}

resource "oci_core_vcn" "this" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = local.vcn_display_name
  dns_label      = substr(local.vcn_dns_label, 0, 15)
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = local.igw_display_name
  vcn_id         = oci_core_vcn.this.id
  enabled        = true
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  display_name   = local.rt_display_name
  vcn_id         = oci_core_vcn.this.id

  route_rules {
    description       = "Default route to Internet Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_id
  display_name   = local.sl_display_name
  vcn_id         = oci_core_vcn.this.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    description = "Allow SSH"
    protocol    = "6" # TCP
    source      = var.ssh_ingress_cidr
    tcp_options {
      min = 22
      max = 22
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.allow_http_https ? [80, 443] : []
    content {
      description = ingress_security_rules.value == 80 ? "Allow HTTP" : "Allow HTTPS"
      protocol    = "6"
      source      = "0.0.0.0/0"
      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.docker_ports
    content {
      description = "Allow Docker app port ${ingress_security_rules.value}"
      protocol    = "6"
      source      = "0.0.0.0/0"
      tcp_options {
        min = ingress_security_rules.value
        max = ingress_security_rules.value
      }
    }
  }
}

resource "oci_core_subnet" "public" {
  cidr_block                 = var.public_subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = local.subnet_public_name
  dns_label                  = local.subnet_public_dns
  prohibit_public_ip_on_vnic = false
  route_table_id             = oci_core_route_table.public.id
  security_list_ids          = [oci_core_security_list.public.id]
  vcn_id                     = oci_core_vcn.this.id
}

resource "oci_core_subnet" "private" {
  cidr_block                 = var.private_subnet_cidr
  compartment_id             = var.compartment_id
  display_name               = local.subnet_priv_name
  dns_label                  = local.subnet_priv_dns
  prohibit_public_ip_on_vnic = true
  vcn_id                     = oci_core_vcn.this.id
}


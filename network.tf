## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "datas_vcn" {
  cidr_block     = var.VCN-CIDR
  display_name   = var.datas_vcn_display_name
  compartment_id = var.compartment_ocid
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_dhcp_options" "datas_dhcpOptions1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.datas_vcn.id
  display_name   = "datas_dhcpOptions1"

  // required
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type                = "SearchDomain"
    search_domain_names = ["example.com"]
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_internet_gateway" "datas_internetgateway" {
  compartment_id = var.compartment_ocid
  display_name   = "DataScience InternetGateway"
  vcn_id         = oci_core_vcn.datas_vcn.id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_nat_gateway" "datas_natgateway" {
  compartment_id = var.compartment_ocid
  display_name   = "DataScience NATGateway"
  vcn_id         = oci_core_vcn.datas_vcn.id
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "datas_routetable_viaIGW" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.datas_vcn.id
  display_name   = "datas_routetable_viaIGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.datas_internetgateway.id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_route_table" "datas_routetable_viaNAT" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.datas_vcn.id
  display_name   = "datas_routetable_viaNAT"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.datas_natgateway.id
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "datas_subnet_public" {
  cidr_block      = var.Public_Subnet-CIDR
  compartment_id  = var.compartment_ocid
  vcn_id          = oci_core_vcn.datas_vcn.id
  display_name    = "datas_subnet"
  route_table_id  = oci_core_route_table.datas_routetable_viaIGW.id
  dhcp_options_id = oci_core_dhcp_options.datas_dhcpOptions1.id
  defined_tags    = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_subnet" "datas_subnet_private" {
  cidr_block                 = var.Private_Subnet-CIDR
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.datas_vcn.id
  display_name               = "datas_subnet"
  route_table_id             = oci_core_route_table.datas_routetable_viaNAT.id
  dhcp_options_id            = oci_core_dhcp_options.datas_dhcpOptions1.id
  prohibit_public_ip_on_vnic = true
  defined_tags               = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_drg" "datas_drg" {
  compartment_id = var.compartment_ocid
  display_name   = var.datas_drg_display_name
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_drg_attachment" "drg01_dmz_attachment" {
  drg_id       = oci_core_drg.datas_drg.id
  vcn_id       = oci_core_vcn.datas_vcn.id
  display_name = var.datas_drg_attachment_display_name
}

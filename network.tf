## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "datas_vcn" {
  cidr_block     = var.VCN-CIDR
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

resource "oci_core_security_list" "datas_securitylist" {
  compartment_id = var.compartment_ocid
  display_name   = "datas_securitylist"
  vcn_id         = oci_core_vcn.datas_vcn.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.service_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_core_internet_gateway" "datas_internetgateway" {
  compartment_id = var.compartment_ocid
  display_name   = "datas InternetGateway"
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

resource "oci_core_subnet" "datas_subnet" {
  cidr_block        = var.Subnet-CIDR
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.datas_vcn.id
  display_name      = "datas_subnet"
  route_table_id    = oci_core_route_table.datas_routetable_viaIGW.id
  dhcp_options_id   = oci_core_dhcp_options.datas_dhcpOptions1.id
  security_list_ids = [oci_core_security_list.datas_securitylist.id]
  defined_tags      = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

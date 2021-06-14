resource "oci_core_subnet" "datas_subnet" {
  cidr_block     = "10.0.1.0/24"
  compartment_id = var.compartment
  vcn_id         = oci_core_vcn.datas_vcn.id
  display_name = "datas_subnet"
  route_table_id = oci_core_route_table.datas_routetable_viaIGW.id
  dhcp_options_id = oci_core_dhcp_options.datas_dhcpOptions1.id
  security_list_ids = [oci_core_security_list.datas_securitylist.id]
}

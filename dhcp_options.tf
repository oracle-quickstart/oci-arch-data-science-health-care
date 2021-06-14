resource "oci_core_dhcp_options" "datas_dhcpOptions1" {
  compartment_id = var.compartment
  vcn_id = oci_core_vcn.datas_vcn.id
  display_name = "datas_dhcpOptions1"

  // required
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type = "SearchDomain"
    search_domain_names = [ "foggykitchen.com" ]
  }
}

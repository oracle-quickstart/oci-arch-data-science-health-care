resource "oci_core_route_table" "datas_routetable_viaIGW" {
    compartment_id = var.compartment
    vcn_id = oci_core_vcn.datas_vcn.id
    display_name = "datas_routetable_viaIGW"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_internet_gateway.datas_internetgateway.id
    }
}

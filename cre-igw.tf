resource "oci_core_internet_gateway" "datas_internetgateway" {
    compartment_id = var.compartment
    display_name = "datas InternetGateway"
    vcn_id = oci_core_vcn.datas_vcn.id
}

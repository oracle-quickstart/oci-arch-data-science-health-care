resource "oci_core_vcn" "datas_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment
}

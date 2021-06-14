resource "oci_objectstorage_bucket" "datas-bucket1" {
  compartment_id = var.compartment
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "datas-bucket"
  access_type    = "NoPublicAccess"
  auto_tiering = "Disabled"
}

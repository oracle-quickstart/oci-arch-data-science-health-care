## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_objectstorage_namespace_metadata" "namespace-metadata1" {
  namespace                = data.oci_objectstorage_namespace.ns.namespace
  default_s3compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "datas-bucket1" {
  compartment_id = var.compartment_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = "datas-bucket"
  access_type    = "NoPublicAccess"
  auto_tiering   = "Disabled"
}

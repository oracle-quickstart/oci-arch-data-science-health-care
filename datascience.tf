## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_datascience_project" "ds_project" {
  compartment_id = var.compartment_ocid
  display_name   = var.project_display_name
  defined_tags   = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_datascience_notebook_session" "ds_notebook_session" {
  compartment_id = var.compartment_ocid

  notebook_session_configuration_details {
    shape     = var.Shape
    subnet_id = oci_core_subnet.datas_subnet.id
  }

  project_id   = oci_datascience_project.ds_project.id
  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


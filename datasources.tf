## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_ocid
}

data "oci_objectstorage_namespace_metadata" "namespace-metadata1" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
}


data "oci_core_vnic_attachments" "datas_instance1_vnic1_attach" {
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  instance_id         = oci_core_instance.datas_instance1.id
}

data "oci_core_vnic" "datas_instance1_vnic1" {
  vnic_id = data.oci_core_vnic_attachments.datas_instance1_vnic1_attach.vnic_attachments.0.vnic_id
}

data "oci_core_vnic_attachments" "datas_instance2_vnic1_attach" {
  availability_domain = var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  instance_id         = oci_core_instance.datas_instance1.id
}

data "oci_core_vnic" "datas_instance2_vnic1" {
  vnic_id = data.oci_core_vnic_attachments.datas_instance2_vnic1_attach.vnic_attachments.0.vnic_id
}


# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.Shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "oci_datascience_notebook_session_shapes" "ds_notebook_session_shapes" {
  compartment_id = var.compartment_ocid
}

data "oci_datascience_projects" "ds_projects" {
  compartment_id = var.compartment_ocid
  display_name   = var.project_display_name
}

data "oci_datascience_notebook_sessions" "ds_notebook_sessions" {
  compartment_id = var.compartment_ocid
}



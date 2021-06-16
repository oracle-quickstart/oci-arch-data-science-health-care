## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "region" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "availablity_domain_name" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.0"
}

variable "project_display_name" {
  default = "MyDataScienceProject"
}

variable "notebook_session_display_name" {
  default = "MyDataScienceNotebookSession"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "Subnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "Shape" {
  default = "VM.Standard.E3.Flex"
}

variable "FlexShapeOCPUS" {
  default = 1
}

variable "FlexShapeMemory" {
  default = 1
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = "10"
}

variable "flex_lb_max_shape" {
  default = "100"
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "7.9"
}

variable "service_ports" {
  default = [80, 443, 22]
}

variable "ssh_public_key" {
  default = ""
}

variable "autonomous_database_admin_password" {
  default = ""
}

variable "autonomous_database_cpu_core_count" {
  default = 1
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = 1
}

variable "autonomous_database_db_name" {
  default = "DataScienceDB"
}

variable "autonomous_database_db_version" {
  default = "19c"
}

variable "autonomous_database_display_name" {
  default = "DataScience ADW DB"
}

variable "autonomous_database_is_auto_scaling_enabled" {
  default = false
}

variable "autonomous_database_license_model" {
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "autonomous_database_whitelisted_ips" {
  type    = list(string)
  default = [""]
}

variable "analytics_instance_feature_set" {
  default = "ENTERPRISE_ANALYTICS"
}

variable "analytics_instance_license_type" {
  default = "LICENSE_INCLUDED"
}

variable "analytics_instance_name" {
  default = "DSC1"
}

variable "analytics_instance_idcs_access_token" {
  default = ""
}

variable "analytics_instance_capacity_capacity_type" {
  default = "OLPU_COUNT"
}

variable "analytics_instance_capacity_capacity_value" {
  default = 1
}

#------------------

variable "catalog_display_name" {
  default = "DS_DataCatalog"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_shape    = contains(local.compute_flexible_shapes, var.Shape)
  is_flexible_lb_shape = var.lb_shape == "flexible" ? true : false
}

variable "region" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_oci" {}
variable "public_key_oci" {}

variable "compartment" {
  default = "ocid1.compartment.oc1..aaaaaaaacrwyqytswze7bdtkh2hex7wylahjvg45o5lbaufbtub5k3mrcika"
}

variable "project_display_name" {
  default = "MyDataScience1"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "Subnet-CIDR" {
  default = "10.0.1.0/24"
}
variable "ADs" {
  default = "GrCh:US-ASHBURN-AD-2"
}

variable "shape" {
 default = "VM.Standard.E2.2"
}
variable "image" {
 default = "ocid1.image.oc1.iad.aaaaaaaaw2wavtqrd3ynbrzabcnrs77pinccp55j2gqitjrrj2vf65sqj5kq"
}

variable "FlexShapeOCPUS" {
    default = 1
}

variable "FlexShapeMemory" {
    default = 1
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "7.9"
}

variable "service_ports" {
  default = [80,443,22]
}
variable "ssh_public_key" {
  default = ""
}
variable "ssh_authorized_keys" {
  default = "/home/opc/.ssh/id_rsa.pub"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
#locals {
#  is_flexible_shape = contains(local.compute_flexible_shapes, var.Shape)
#}


variable "autonomous_database_admin_password" {
  default = "C0nstellat10n"
}

variable "autonomous_database_cpu_core_count" {
  default = "1"
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = "1"
}

variable "autonomous_database_db_name" {
  default = "DataSciencedb"
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

#-------------


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
#  default = "3aNPS[D.1#.rF90qo}me"
  default = "ocid1.credential.oc1..aaaaaaaas4ejrzeajm67apayvynp7poqdcrvdz76fkhmriw37gyi5qjv6wza"
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

resource "oci_database_autonomous_database" "ds_autonomous_db" {
    admin_password           = var.autonomous_database_admin_password
    compartment_id           = var.compartment
    cpu_core_count           = var.autonomous_database_cpu_core_count
    data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
    db_name                  = var.autonomous_database_db_name
    db_version               = var.autonomous_database_db_version
    db_workload              = "DW"
    display_name             = var.autonomous_database_display_name
    is_auto_scaling_enabled  = var.autonomous_database_is_auto_scaling_enabled
    license_model            = var.autonomous_database_license_model
    whitelisted_ips          = var.autonomous_database_whitelisted_ips
}

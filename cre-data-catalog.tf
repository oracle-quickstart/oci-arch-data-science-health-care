# Create Data Catalog

resource "oci_datacatalog_catalog" "ds_data_catalog" {
    #Required
    compartment_id = var.compartment
    display_name = var.catalog_display_name
}

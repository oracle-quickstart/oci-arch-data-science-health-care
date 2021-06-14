data "oci_datascience_notebook_session_shapes" "ds_notebook_session_shapes" {
  compartment_id = var.compartment
}


resource "oci_datascience_project" "ds_project" {
  compartment_id = var.compartment
  display_name  = var.project_display_name
}

data "oci_datascience_projects" "ds_projects" {

  compartment_id = var.compartment
  display_name  = var.project_display_name
}

resource "oci_datascience_notebook_session" "ds_notebook_session" {
  compartment_id = var.compartment

  notebook_session_configuration_details {
    shape     = var.shape
    subnet_id = oci_core_subnet.datas_subnet.id
  }

  project_id = oci_datascience_project.ds_project.id
}

data "oci_datascience_notebook_sessions" "ds_notebook_sessions" {
  compartment_id = var.compartment
}

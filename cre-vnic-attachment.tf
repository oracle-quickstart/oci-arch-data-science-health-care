
data "oci_core_vnic_attachments" "datas_instance1_vnic1_attach"{
  availability_domain = var.ADs
  compartment_id = var.compartment
  instance_id = oci_core_instance.datas_instance1.id
}

data "oci_core_vnic" "datas_instance1_vnic1" {
  vnic_id = data.oci_core_vnic_attachments.datas_instance1_vnic1_attach.vnic_attachments.0.vnic_id
}

data "oci_core_vnic_attachments" "datas_instance2_vnic1_attach"{
  availability_domain = var.ADs
  compartment_id = var.compartment
  instance_id = oci_core_instance.datas_instance1.id
}

data "oci_core_vnic" "datas_instance2_vnic1" {
  vnic_id = data.oci_core_vnic_attachments.datas_instance2_vnic1_attach.vnic_attachments.0.vnic_id
}

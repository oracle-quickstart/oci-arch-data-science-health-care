resource "oci_core_instance" "datas_instance1" {
  availability_domain = var.ADs
  compartment_id = var.compartment
  display_name = "datasience"
  shape = var.shape
  fault_domain = "FAULT-DOMAIN-1"
  source_details {
     source_type = "image"
     source_id   = var.image
   }

  create_vnic_details {
     subnet_id = oci_core_subnet.datas_subnet.id
     assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = "${file("${var.ssh_authorized_keys}")}"
  }
}

resource "oci_core_instance" "datas_instance2" {
  availability_domain = var.ADs
  compartment_id = var.compartment
  display_name = "datasience"
  shape = var.shape
  fault_domain = "FAULT-DOMAIN-2"
  source_details {
     source_type = "image"
     source_id   = var.image
   }

  create_vnic_details {
     subnet_id = oci_core_subnet.datas_subnet.id
     assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = "${file("${var.ssh_authorized_keys}")}"
  }
}

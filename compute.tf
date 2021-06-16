## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "template_file" "key_script" {
  template = file("./scripts/sshkey.tpl")
  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.key_script.rendered
  }
}

resource "oci_core_instance" "datas_instance" {
  count               = var.NumberOfAppVMs
  availability_domain = var.availablity_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[0]["name"] : var.availablity_domain_name
  compartment_id      = var.compartment_ocid
  display_name        = "datasience-${count.index}"
  shape               = var.Shape

  dynamic "shape_config" {
    for_each = local.is_flexible_shape ? [1] : []
    content {
      memory_in_gbs = var.FlexShapeMemory
      ocpus         = var.FlexShapeOCPUS
    }
  }

  fault_domain = "FAULT-DOMAIN-${(count.index % 3) + 1}"

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.InstanceImageOCID.images[0].id
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.datas_subnet_private.id
    assign_public_ip = false
    nsg_ids          = [oci_core_network_security_group.SSHSecurityGroup.id, oci_core_network_security_group.APPSecurityGroup.id]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = data.template_cloudinit_config.cloud_init.rendered
  }

  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


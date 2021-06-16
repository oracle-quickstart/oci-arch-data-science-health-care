## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "null_resource" "datas_instance-config" {
  depends_on = [oci_core_instance.datas_instance]
  count      = var.NumberOfAppVMs

  provisioner "remote-exec" {
    connection {
      type                = "ssh"
      user                = "opc"
      host                = data.oci_core_vnic.datas_instance_vnic[count.index].private_ip_address
      private_key         = tls_private_key.public_private_key_pair.private_key_pem
      script_path         = "/home/opc/myssh.sh"
      agent               = false
      timeout             = "10m"
      bastion_host        = var.use_bastion_service ? "host.bastion.${var.region}.oci.oraclecloud.com" : oci_core_instance.bastion_instance[0].public_ip
      bastion_port        = "22"
      bastion_user        = var.use_bastion_service ? oci_bastion_session.ssh_via_bastion_service[count.index].id : "opc"
      bastion_private_key = tls_private_key.public_private_key_pair.private_key_pem

    }
    inline = [
      "sudo yum -y update",
      "hostname"
    ]
  }

}



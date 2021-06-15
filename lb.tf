## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_load_balancer" "datas_lb1" {
  shape = var.lb_shape

  dynamic "shape_details" {
    for_each = local.is_flexible_lb_shape ? [1] : []
    content {
      minimum_bandwidth_in_mbps = var.flex_lb_min_shape
      maximum_bandwidth_in_mbps = var.flex_lb_max_shape
    }
  }

  compartment_id = var.compartment_ocid
  subnet_ids = [
    oci_core_subnet.datas_subnet.id
  ]
  display_name = "DataScience LB"

  defined_tags = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_load_balancer_backendset" "datas_lb1_Backendset" {
  name             = "datas_lb1_Backendset"
  load_balancer_id = oci_load_balancer.datas_lb1.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_listener" "datas_lb_Listener" {
  load_balancer_id         = oci_load_balancer.datas_lb1.id
  name                     = "datas_lb_Listener"
  default_backend_set_name = oci_load_balancer_backendset.datas_lb1_Backendset.name
  port                     = 80
  protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "datas_lb1_Backend" {
  load_balancer_id = oci_load_balancer.datas_lb1.id
  backendset_name  = oci_load_balancer_backendset.datas_lb1_Backendset.name
  ip_address       = oci_core_instance.datas_instance1.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "datas_lb1_Backend2" {
  load_balancer_id = oci_load_balancer.datas_lb1.id
  backendset_name  = oci_load_balancer_backendset.datas_lb1_Backendset.name
  ip_address       = oci_core_instance.datas_instance2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

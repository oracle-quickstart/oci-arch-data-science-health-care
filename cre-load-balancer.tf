resource "oci_load_balancer" "datas_lb1" {
  shape = "100Mbps"
  compartment_id = var.compartment
  subnet_ids     = [
    oci_core_subnet.datas_subnet.id
  ]
  display_name   = "DataScience LB"
}

resource "oci_load_balancer_backendset" "datas_lb1_Backendset" {
  name             = "datas_lb1_Backendset"
  load_balancer_id = oci_load_balancer.datas_lb1.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
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

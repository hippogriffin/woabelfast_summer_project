# ELB for WordPress Servers

resource "aws_elb" "preview_wordpress_elb" {
  name    = "preview-wordpress-elb"
  subnets = ["${aws_instance.wordpress.*.subnet_id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.wordpress.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name        = "${local.preview_wp_server_elb}"
    terraform   = "true"
    Environment = "${var.environment}"
  }
}

# ELB for webservers
resource "aws_elb" "preview_webserver_elb" {
  name                        = "${local.preview_webserver_elb}"
  subnets                     = ["${aws_subnet.preview_public_subnet.id}"]
  instances                   = ["${aws_instance.proxy-servers.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups             = ["${aws_security_group.preview_web_servers.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  #     listener {
  #        instance_port      = 443
  #        instance_protocol  = "http"
  #        lb_port            = 443
  #        lb_protocol        = "https"
  #        ssl_certificate_id = ""
  #     }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  tags {
    Name        = "${local.preview_webserver_elb}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}

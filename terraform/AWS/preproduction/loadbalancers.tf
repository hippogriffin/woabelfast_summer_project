# ELB for WordPress Servers
resource "aws_elb" "preproduction_wordpress_elb" {
  name            = "preproduction-wordpress-elb"
  subnets         = ["${aws_instance.wordpress.*.subnet_id}"]
  security_groups = ["${aws_security_group.preproduction_wp_servers.id}"]
  internal        = true

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
    target              = "HTTP:80/elb_status"
    interval            = 30
  }

  instances                   = ["${aws_instance.wordpress.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name        = "${local.preproduction_wp_server_elb}"
    terraform   = "true"
    Environment = "${var.environment}"
  }
}

# ELB for webservers
resource "aws_elb" "preproduction_webserver_elb" {
  name                        = "${local.preproduction_webserver_elb}"
  subnets                     = ["${aws_subnet.preproduction_public_subnet-1a.id}", "${aws_subnet.preproduction_public_subnet-1b.id}"]
  instances                   = ["${aws_instance.proxy-servers.*.id}"]
  security_groups             = ["${aws_security_group.preproduction_elb_public_sg.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  internal                    = false

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_acm_certificate_validation.cert.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/elb_status"
    interval            = 30
  }

  tags {
    Name        = "${local.preproduction_webserver_elb}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}

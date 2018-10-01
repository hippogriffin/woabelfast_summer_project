# ELB for WordPress Servers
resource "aws_elb" "wordpress_elb" {
  name            = "${var.environment}-wordpress-elb"
  subnets         = ["${aws_instance.wordpress.*.subnet_id}"]
  security_groups = ["${aws_security_group.wp_servers.id}"]
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
    Name        = "${local.wp_server_elb}"
    terraform   = "true"
    Environment = "${var.environment}"
  }
}

# ELB for webservers
resource "aws_elb" "webserver_elb" {
  name                        = "${local.webserver_elb}"
  subnets                     = ["${aws_subnet.public_subnet-1a.id}", "${aws_subnet.public_subnet-1b.id}"]
  instances                   = ["${aws_instance.proxy-servers.*.id}"]
  security_groups             = ["${aws_security_group.elb_public_sg.id}"]
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
    ssl_certificate_id = "${aws_iam_server_certificate.aws_cert.arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/elb_status"
    interval            = 30
  }

  tags {
    Name        = "${local.webserver_elb}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
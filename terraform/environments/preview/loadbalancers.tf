# Create a load balancer for the wordpress servers 
# This will send traffic to both servers - increasing availability 

resource "aws_elb" "preview_wordpress_elb" {
  name      = "preview-wordpress-elb"
  subnets   = ["${aws_instance.wordpress.*.subnet_id}"]

  access_logs {
    bucket            = "woa-belfast"
    interval          = 60
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.wordpress.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.environment}-wordpress-elb"
    terraform = "true"
    Environment = "${var.environment}"
  }
}
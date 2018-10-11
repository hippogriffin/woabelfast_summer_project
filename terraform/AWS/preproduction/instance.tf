# EC2 Instances

resource "aws_instance" "wordpress" {
  ami                    = "${var.ami}"
  count                  = "${var.instance_count}"
  instance_type          = "${var.wordpress_instance_type}"
  subnet_id              = "${aws_subnet.wordpress.id}"
  vpc_security_group_ids = ["${aws_security_group.wp_servers.id}"]
  private_ip             = "${format("${local.wp_server_ips}", count.index + 10)}"
  key_name               = "${aws_key_pair.key.key_name}"
  user_data              = "${file("scripts/init.cfg")}"
  availability_zone      = "${var.avail_zone_a}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags {
    Name        = "${format("${local.wp_server_names}", count.index + 1)}"
    Environment = "${var.environment}"
    Role        = "${var.wp_server_name}"
    EnvRole     = "${local.wp_env_role}"
  }
}

resource "aws_instance" "proxy-servers" {
  ami                    = "${var.ami}"
  count                  = "${var.instance_count}"
  instance_type          = "${var.proxy_instance_type}"
  subnet_id              = "${aws_subnet.webserver_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.web_servers.id}"]
  private_ip             = "${format("${local.webserver_ips}", count.index + 10)}"
  key_name               = "${aws_key_pair.key.key_name}"
  user_data              = "${file("scripts/init.cfg")}"
  availability_zone      = "${var.avail_zone_a}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags {
    Name        = "${format("${local.webserver_names}", count.index + 1)}"
    Environment = "${var.environment}"
    Role        = "${var.webserver_name}"
    EnvRole     = "${local.proxy_env_role}"
  }
}

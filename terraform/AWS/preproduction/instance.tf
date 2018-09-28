# EC2 Instances in the Preproduction Environment

resource "aws_instance" "wordpress" {
  ami                    = "${var.ami}"
  count                  = "${var.instance_count}"
  instance_type          = "${var.wordpress_instance_type}"
  subnet_id              = "${aws_subnet.preproduction_wordpress.id}"
  vpc_security_group_ids = ["${aws_security_group.preproduction_wp_servers.id}"]
  private_ip             = "${format("${local.preproduction_wp_server_ips}", count.index + 10)}"
  key_name               = "${aws_key_pair.preproduction_key.key_name}"
  user_data              = "${file("scripts/init.cfg")}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags {
    Name        = "${format("${local.preproduction_wp_server_names}", count.index + 1)}"
    Environment = "${var.environment}"
    Role        = "${var.preproduction_wp_server_name}"
    EnvRole     = "${local.preproduction_wp_env_role}"
  }
}

resource "aws_instance" "proxy-servers" {
  ami                    = "${var.ami}"
  count                  = "${var.instance_count}"
  instance_type          = "${var.proxy_instance_type}"
  subnet_id              = "${aws_subnet.preproduction_webserver_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.preproduction_web_servers.id}"]
  private_ip             = "${format("${local.preproduction_webserver_ips}", count.index + 10)}"
  key_name               = "${aws_key_pair.preproduction_key.key_name}"
  user_data              = "${file("scripts/init.cfg")}"

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags {
    Name        = "${format("${local.preproduction_webserver_names}", count.index + 1)}"
    Environment = "${var.environment}"
    Role        = "${var.preproduction_webserver_name}"
    EnvRole     = "${local.preproduction_proxy_env_role}"
  }
}

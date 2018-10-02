resource "aws_efs_file_system" "wordpress" {
  tags {
    Name = "${var.environment}WordpressStorage"
  }
}

resource "aws_efs_mount_target" "wordpress" {
  file_system_id  = "${aws_efs_file_system.wordpress.id}"
  subnet_id       = "${aws_subnet.wordpress.id}"
  security_groups = ["${aws_security_group.wp_servers.id}"]
}

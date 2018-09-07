resource "aws_efs_file_system" "wordpress" {

  tags {
    Name = "WordpressStorage"
  }
}

resource "aws_efs_mount_target" "wordpress" {
  file_system_id = "${aws_efs_file_system.wordpress.id}"
  subnet_id      = "${aws_subnet.preview_wordpress.id}"
  security_groups = ["${aws_security_group.wp_servers.id}"]
}
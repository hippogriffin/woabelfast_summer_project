resource "aws_efs_file_system" "preproduction_wordpress" {
  tags {
    Name = "PreproductionWordpressStorage"
  }
}

resource "aws_efs_mount_target" "wordpress" {
  file_system_id  = "${aws_efs_file_system.preproduction_wordpress.id}"
  subnet_id       = "${aws_subnet.preproduction_wordpress.id}"
  security_groups = ["${aws_security_group.preproduction_wp_servers.id}"]
}

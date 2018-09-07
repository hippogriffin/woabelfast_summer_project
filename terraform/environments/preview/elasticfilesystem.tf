resource "aws_efs_file_system" "wordpress" {

  tags {
    Name = "WordpressStorage"
  }
}

resource "aws_efs_mount_target" "alpha" {
  file_system_id = "${aws_efs_file_system.wordpress.id}"
  subnet_id      = "${aws_subnet.preview_wordpress.id}"

}
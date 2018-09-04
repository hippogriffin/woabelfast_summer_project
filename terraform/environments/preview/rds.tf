resource "aws_db_instance" "preview_rds" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "${var.preview_rds}"
  username             = "wpuser"
  password             = "12345"
  parameter_group_name = "default.mysql5.7"
}
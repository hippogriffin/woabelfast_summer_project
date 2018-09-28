resource "aws_db_instance" "preproduction_rds" {
  identifier             = "preproduction-rds"
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "${var.preproduction_rds}"
  username               = "wpuser"
  password               = "123456789"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = "${aws_db_subnet_group.preproduction_rds_subnet_group.id}"
  vpc_security_group_ids = ["${aws_security_group.preproduction_db.id}", "${aws_security_group.preproduction_db_backup.id}"]
  skip_final_snapshot    = true

  tags {
    Name        = "preproduction_rds"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}

resource "aws_db_subnet_group" "preproduction_rds_subnet_group" {
  name       = "main"
  subnet_ids = ["${aws_subnet.preproduction_db_subnet.id}", "${aws_subnet.preproduction_db_subnet_backup.id}"]

  tags {
    Name = "Preproduction RDS Subnet Group"
  }
}

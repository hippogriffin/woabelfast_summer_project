 resource "aws_db_security_group" "preview" {
  name = "preview_rds_sg"

  ingress {
    cidr = "10.0.0.0/24"
  }
}

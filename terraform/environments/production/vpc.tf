# Production VPC 
resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.124.0.0/24"
  tags {
    Name = "${var.environment}"
  }
}
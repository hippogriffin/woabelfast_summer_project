# Production VPC 

resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.124.0.0/24"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.environment}"
  }
}
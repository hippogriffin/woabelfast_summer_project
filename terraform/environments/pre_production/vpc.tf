# Pre-Prod VPC 

resource "aws_vpc" "pre_prod_vpc" {
  cidr_block = "10.123.0.0/24"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.environment}"
  }
}
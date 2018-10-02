# Preproduction VPC

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_ip}"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.environment} VPC"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
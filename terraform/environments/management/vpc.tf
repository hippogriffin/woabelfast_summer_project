# Management VPC 

resource "aws_vpc" "mgmt_vpc" {
  cidr_block = "10.121.0.0/24"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.environment}"
    Terraform = "true"
    Environment = "${var.environment}"
  }
}
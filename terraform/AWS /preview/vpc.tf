# Preview VPC

resource "aws_vpc" "preview_vpc" {
  cidr_block = "10.122.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "Preview VPC"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

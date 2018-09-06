# DMZ VPC 

resource "aws_vpc" "dmz_vpc" {
  cidr_block = "10.120.0.0/24"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.environment}"
  }
}

output "dmz_vpc_id" {
  value = "${aws_vpc.dmz_vpc.id}"

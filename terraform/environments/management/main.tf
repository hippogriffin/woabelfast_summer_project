provider "aws" {
  region = "eu-west-1"
}

output "mgmt_vpc_id" {
  value = "${aws_vpc.mgmt_vpc.id}"
}
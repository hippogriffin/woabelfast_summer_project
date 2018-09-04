provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "private_dns" {
  name = "woabelfast.local"
  vpc_id  = "${aws_vpc.mgmt.id}"
  tags {
    Name = "private_zone"
  }
}

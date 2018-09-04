provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "dmz_vpc" {
    cidr_block = "10.120.0.0/24"
    region = "eu-west-1"
}

resource "aws_route53_zone" "private_dns" {
  name = "woabelfast.local"
  vpc_id  = "${aws_vpc.dmz_vpc.id}"
  tags {
    Name = "private_zone"
  }
}

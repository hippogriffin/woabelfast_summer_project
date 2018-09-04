provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "management" {
  name = "management.woabelfast.local"
  vpc_id  = "${aws_vpc.mgmt_vpc.id}"
  tags {
    Environment = "management"
  }
}

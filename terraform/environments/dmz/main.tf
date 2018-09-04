provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "dmz" {
  name = "dmz.woabelfast.local"
  vpc_id  = "${aws_vpc.mgmt.id}"
  tags {
    Environment = "dmz"
  }
}

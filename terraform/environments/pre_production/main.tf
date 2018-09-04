provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "pre-production" {
  name = "pre_production.woabelfast.local"
  vpc_id  = "${aws_vpc.pre_prod_vpc.id}"
  tags {
    Environment = "pre_production"
  }
}

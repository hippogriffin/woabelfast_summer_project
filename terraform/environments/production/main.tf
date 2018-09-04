provider "aws" {
  region = "eu-west-1"
}


resource "aws_route53_zone" "production" {
  name = "production.woabelfast.local"
  vpc_id  = "${aws_vpc.prod_vpc.id}"
  tags {
    Environment = "production"
  }
}

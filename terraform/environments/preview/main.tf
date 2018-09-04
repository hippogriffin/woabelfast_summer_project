provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "preview" {
  name = "preview.woabelfast.local"
  vpc_id  = "${aws_vpc.preview_vpc.id}"
  tags {
    Environment = "preview"
  }
}

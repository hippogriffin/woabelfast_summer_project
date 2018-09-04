provider "aws" {
  region = "eu-west-1"
}

resource "aws_route53_zone" "main" {
  name = "woabelfast.co.uk"
}

resource "aws_route53_zone" "management" {
  name = "management.woabelfast.co.uk"

  tags {
    Environment = "management"
  }
}

resource "aws_route53_record" "management-ns" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "woabelfast.co.uk"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.management.name_servers.0}",
    "${aws_route53_zone.management.name_servers.1}",
    "${aws_route53_zone.management.name_servers.2}",
    "${aws_route53_zone.management.name_servers.3}",
  ]
}
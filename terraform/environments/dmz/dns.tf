resource "aws_route53_zone" "private_dns" {
  name = "woabelfast.local"
  vpc_id  = "${aws_vpc.dmz_vpc.id}"
  tags {
    Name = "private_zone"
    Terraform = "true"
    Environment = "${var.environment}"
  }
}

resource "aws_route53_record" "dmz_dns_record" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "${local.jumpbox_dns_record}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.jumpbox.private_ip}"]
}




#DNS Entries
resource "aws_route53_zone_association" "private_zone" {
  zone_id = "${data.terraform_remote_state.dmz_remote_state.private_zone_id}"
  vpc_id  = "${aws_vpc.vpc.id}"
}

resource "aws_route53_record" "private_dns_records_db" {
  zone_id = "${aws_route53_zone_association.private_zone.zone_id}"
  name    = "${var.rds_wordpress}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_db_instance.rds.address}",
  ]
}

resource "aws_route53_record" "wordpress_elb" {
  zone_id = "${aws_route53_zone_association.private_zone.zone_id}"
  name    = "${local.wp_server_elb}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_elb.wordpress_elb.dns_name}",
  ]
}

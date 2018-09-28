#DNS Entries for preproduction environment

resource "aws_route53_zone_association" "preproduction_private_zone" {
  zone_id = "${data.terraform_remote_state.dmz_remote_state.private_zone_id}"
  vpc_id  = "${aws_vpc.preproduction_vpc.id}"
}

resource "aws_route53_record" "preproduction_private_dns_records_db" {
  zone_id = "${aws_route53_zone_association.preproduction_private_zone.zone_id}"
  name    = "${var.preproduction_rds}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_db_instance.preproduction_rds.address}",
  ]
}

resource "aws_route53_record" "preproduction_wordpress_elb" {
  zone_id = "${aws_route53_zone_association.preproduction_private_zone.zone_id}"
  name    = "${local.preproduction_wp_server_elb}"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_elb.preproduction_wordpress_elb.dns_name}",
  ]
}

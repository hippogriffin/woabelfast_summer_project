#DNS Entries for preview environment

resource "aws_route53_zone_association" "preview_private_zone" {
  zone_id = "${data.terraform_remote_state.dmz_remote_state.private_zone_id}"
  vpc_id  = "${aws_vpc.preview_vpc.id}"
}

resource "aws_route53_record" "preview_private_dns_records_webserver" {
  zone_id = "${aws_route53_zone_association.preview_private_zone.zone_id}"
  name = "${format("${local.preview_aws_dns_webserver_names}", count.index + 1)}"
  type = "A"
  ttl = "300"
  count = "${var.instance_count}"

  records = [
    "${format("${local.preview_webserver_ips}", count.index + 10)}",
  ]
}

resource "aws_route53_record" "preview_private_dns_records_wordpress" {
  zone_id = "${aws_route53_zone_association.preview_private_zone.zone_id}"
  name = "${format("${local.preview_aws_dns_wp_names}", count.index + 1)}"
  type = "A"
  ttl = "300"
  count = "${var.instance_count}"

  records = [
    "${format("${local.preview_wp_server_ips}", count.index + 10)}",
  ]
}

resource "aws_route53_record" "preview_private_dns_records_db" {
  zone_id = "${aws_route53_zone_association.preview_private_zone.zone_id}"
  name = "${var.preview_rds}"
  type = "CNAME"
  ttl = "300"

  records = [
    "${aws_db_instance.preview_rds.address}",
  ]
}

resource "aws_route53_record" "preview_wordpress_elb" {
  zone_id = "${aws_route53_zone_association.preview_private_zone.zone_id}"
  name = "${local.preview_wp_server_elb}"
  type = "CNAME"
  ttl = "300"

  records = [
    "${aws_elb.preview_wordpress_elb.dns_name}",
  ]
}
resource "aws_route53_zone_association" "mgmt_private_zone" {
  zone_id = "${data.terraform_remote_state.woa-belfast.private_zone_id}"
  vpc_id  = "${aws_vpc.mgmt_vpc.id}"
}

resource "aws_route53_record" "mgmt_private_dns_records" {
  zone_id = "${aws_route53_zone_association.mgmt_private_zone.zone_id}"
  name = "${var.jenkins_name}"
  type = "A"
  ttl = "300"

  records = [
    "${aws_instance.Jenkins.private_ip}",
  ]
}
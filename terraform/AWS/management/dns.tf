resource "aws_route53_zone_association" "mgmt_private_zone" {
  zone_id = "${data.terraform_remote_state.woa-belfast.private_zone_id}"
  vpc_id  = "${aws_vpc.mgmt_vpc.id}"
}

resource "aws_route53_record" "mgmt_private_dns_records" {
  zone_id = "${aws_route53_zone_association.mgmt_private_zone.zone_id}"
  name    = "${local.jenkins_aws_dns_name}"
  type    = "A"
  ttl     = "300"

  records = [
    "${aws_instance.Jenkins.private_ip}",
  ]
}

resource "aws_route53_record" "azure_dns_records_jumpbox" {
  zone_id = "${data.terraform_remote_state.woa-belfast.private_zone_id}"
  name    = "${local.bastion_azure_dns_name}"
  type    = "A"
  ttl     = "300"

  records = [
    "172.16.1.4",
  ]
}

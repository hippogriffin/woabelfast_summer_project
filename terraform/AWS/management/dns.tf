resource "aws_route53_zone_association" "mgmt_private_zone" {
  zone_id = "${data.terraform_remote_state.woa-belfast.private_zone_id}"
  vpc_id  = "${aws_vpc.mgmt_vpc.id}"
}

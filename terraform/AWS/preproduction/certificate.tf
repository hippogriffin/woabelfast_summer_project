/* resource "aws_acm_certificate" "cert" {
  domain_name       = "preproduction.woabelfast.co.uk"
  validation_method = "DNS"
}

data "aws_route53_zone" "zone" {
  name         = "woabelfast.co.uk."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
} */


resource "aws_iam_server_certificate" "aws_cert" {
  name              = "${var.environment}_aws_cert"
  certificate_body  = "${file("certificates/cert.pem")}"
  certificate_chain = "${file("certificates/chain.pem")}"
  private_key       = "${file("certificates/privkey.pem")}"
}
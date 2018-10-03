# Route53 record pointing to the Azure App GW 
resource "aws_route53_record" "www-preproduction-agw" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.environment}.woabelfast.co.uk"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "${var.environment}-agw"
  records        = ["${data.azurerm_public_ip.app_gw_public_ip.fqdn}"]
}
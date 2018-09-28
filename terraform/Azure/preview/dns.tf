# Route53 record pointing to the Azure App GW 
resource "aws_route53_record" "www-preview-agw" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "preview.woabelfast.co.uk"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "preview-agw"
  records        = ["${data.azurerm_public_ip.preview_app_gw_public_ip.fqdn}"]
}
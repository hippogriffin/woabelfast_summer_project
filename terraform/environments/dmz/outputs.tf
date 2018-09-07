
# Creating an output for dmz_vpc_id for use in VPC peering connection
output "dmz_vpc_id" {
  value = "${aws_vpc.dmz_vpc.id}"
}

<<<<<<< HEAD
output "private_zone_id" {
  value = "${aws_route53_zone.private_dns.id}"
=======
output "dmz_vpc_cidr" {
  value = "${aws_vpc.dmz_vpc.cidr_block}"
}

output "dmz_route_table_id" {
  value = "${aws_route_table.dmz_route_table.id}"
}


# Creating an output for private_dns_zone_id for use in mgmt private DNS
output "private_zone_id" {
  value = "${aws_route53_zone.private_dns.zone_id}"
>>>>>>> 347d3e6f8cac4cec6a24fcf1b7e936a80a570d2a
}
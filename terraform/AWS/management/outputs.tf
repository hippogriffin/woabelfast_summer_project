output "mgmt_vpc_id" {
  value = "${aws_vpc.mgmt_vpc.id}"
}

output "mgmt_route_table_id" {
  value = "${aws_route_table.mgmt_private_route_table.id}"
}

# Creating an output for strongswan instance for use in mgmt routing
output "strongswan_instance_id" {
  value = "${aws_instance.strongswan.id}"
}
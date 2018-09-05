
# Creating an output for dmz_vpc_id for use in VPC peering connection
output "dmz_vpc_id" {
  value = "${aws_vpc.dmz_vpc.id}"
}
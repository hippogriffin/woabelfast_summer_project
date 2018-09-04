provider "aws" {
  region = "eu-west-1"
}

#configure management security group
resource "aws_security_group" "${var.woabelfast_security-group}" {
    vpc_id = "${aws_vpc.woabelfast_vpc.id}"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${aws_subnet.dmz_subnet.id}"
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = "${aws_subnet.dmz_subnet.id}"

tags {
    Name = "Allow SSH from ${var.woabelfast_mgmt-subnet} to/from ${var.woabelfast_dmz-subnet}"
}
}
}
#configure management security group
resource "aws_security_group" "${var.woabelfast_security-group}" {
    vpc_id = "${woabelfast_vpc.id}"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.woabelfast_dmz-subnet}"
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = "${var.woabelfast_dmz-subnet}"

tags {
    Name = "Allow SSH from ${var.woabelfast_mgmt-subnet} to/from ${var.woabelfast_dmz-subnet}"
}
}
}
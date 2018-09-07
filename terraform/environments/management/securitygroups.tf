#configure management security group
resource "aws_security_group" "mgmt_sg" {
    name = "${var.security_group_name}"
    description = "Allows SSH to and from dmz subnet and preview subnet"
    vpc_id = "${aws_vpc.mgmt_vpc.id}"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.dmz_cidr}","${var.preview_cidr}"]
    }

    egress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["${var.dmz_cidr}","${var.preview_cidr}"]
    }

    tags {
        Name = "${var.security_group_name}"
        Terraform = "true"
        Environment = "${var.environment}"
        }
}
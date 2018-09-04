#configure management security group
resource "aws_security_group" "mgmt_sg" {
    name = "${var.security_group_name}"
    description = "Allows SSH to and from dmz subnet and preview subnet"
    vpc_id = "${aws_vpc.mgmt_vpc.id}"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.dmz_cidr}"]
    }

    egress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["${var.dmz_cidr}"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${var.preview_cidr}"]
    }

    egress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["${var.preview_cidr}"]
    }

    tags {
        Name = "${var.security_group_name}"
        terraform = "true"
        }
}
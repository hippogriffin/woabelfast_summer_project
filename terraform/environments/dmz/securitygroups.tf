#Configuring DMZ Security Group
resource "aws_security_group" "dmz_sg" {
    name = "${var.security_group_name}"
    description = "Allows ssh, http and https to bastion servers"
    vpc_id = "${aws_vpc.dmz_vpc.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.kainos_cidr}"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.kainos_cidr}"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.kainos_cidr}"]
    }

    tags {
        Name = "${var.security_group_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

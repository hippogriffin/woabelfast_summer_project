#Configuring DMZ Security Group
resource "aws_security_group" "dmz_sg" {
    name = "dmz_sg"
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

    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.mgmt_cidr}", "${var.preview_cidr}", "${var.preprod_cidr}", "${var.production_cidr}"]
    }

    egress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.mgmt_cidr}"]
    }

    tags {
        name = "DMZ_SG"
        terraform = "true"
    }
}

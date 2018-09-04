#Security Groups for the Preview Environment

resource "aws_security_group" "wp_servers" {
    name = "${var.wp_servers_security_group}"
    description = "Security group for Wordpress servers"
    vpc_id = "${aws_vpc.preview_vpc.id}"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["${var.dmz_subnet}"]
    }
    
    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["${var.proxy_subnet}"]
    }

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["${var.proxy_subnet}"]
    }

    tags {
        name = "${var.wp_servers_security_group}"
        terraform = "true"
    }
}

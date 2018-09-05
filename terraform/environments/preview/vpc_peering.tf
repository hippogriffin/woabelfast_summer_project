#VPC Peering configuration for Preview Environment

data "terraform_remote_state" "woa-belfast-mgmt" {
    backend = "s3"
    config {
        bucket = "woa-belfast"
        key = "management/woa.tfstate"
        region = "eu-west-1"
    }
}

resource "aws_vpc_peering_connection" "mgmt_to_preview" {
    vpc_id = "${aws_vpc.preview_vpc.id}"
    peer_vpc_id = "${data.terraform_remote_state.woa-belfast-mgmt.mgmt_vpc_id}"
    auto_accept = "true"

    accepter {
        allow_remote_vpc_dns_resolution = true
    }

    requester {
        allow_remote_vpc_dns_resolution = true
    }

    tags {
        Name = "${var.vpc_peer_name}"
        Terraform = "true"
        Environment = "${var.environment}"
    }
}

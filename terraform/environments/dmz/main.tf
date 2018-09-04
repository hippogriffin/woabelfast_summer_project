provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "dmz_vpc" {
    cidr_block = "10.120.0.0/24"
}

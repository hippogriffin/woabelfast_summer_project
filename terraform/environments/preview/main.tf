provider "aws" {
  region = "eu-west-1"
}

output "preview_vpc_id" {
  value = "${aws_vpc.preview_vpc.id}"
}
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-047bb4163c506cd98"
  instance_type = "t2.micro"
}
resource "aws_instance" "app" {
  ami           = "ami-047bb4163c506cd98"
  instance_type = "t2.micro"
  private_ip    = "10.120.1.0/24"
  
}

resource "aws_instance" "proxy-1" {
  ami           = "ami-047bb4163c506cd98"
  instance_type = "t2.micro"
  private_ip    = "10.120.2.0/24"
}


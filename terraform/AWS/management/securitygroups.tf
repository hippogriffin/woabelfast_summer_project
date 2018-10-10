#configure management security group
resource "aws_security_group" "mgmt_sg" {
  name        = "${var.security_group_name}"
  description = "Allows SSH to and from dmz subnet and preview subnet"
  vpc_id      = "${aws_vpc.mgmt_vpc.id}"


    ingress {
    from_port   = 10050
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_cidr}", "${var.azure_cidr}", "${var.mgmt_cidr}"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_cidr}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.dmz_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.security_group_name}"
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}
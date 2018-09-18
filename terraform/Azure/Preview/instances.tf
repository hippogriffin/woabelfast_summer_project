
resource "azure_instance" "web" {
  name                 = "wordpress-1"
  image                = "7.3.20170925"
  size                 = "Standard_B1s"
  location             = "North Europe"
  username             = "terraform"
  password             = "Pass!admin123"
  domain_name          = "preview.woabelfast.co.uk"

  endpoint {
    name         = "SSH"
    protocol     = "tcp"
    public_port  = 22
    private_port = 22
  }
}
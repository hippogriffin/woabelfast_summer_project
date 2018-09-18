resource "azure_hosted_service" "wordpress-service" {
  name               = "wordpress-service"
  location           = "North Europe"
  ephemeral_contents = false
  description        = "Hosted service created by Terraform."
}

resource "azure_instance" "web" {
  name                 = "wordpress-1"
  hosted_service_name  = "${azure_hosted_service.wordpress-service.name}"
  image                = "7.3.20170925"
  size                 = "Standard_B1s"
  storage_service_name = "yourstorage"
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
output "location" {
    value = "${data.azurerm_network_security_group.test.location}"
}

# Output public ip value for external load balancer
output "publicip_lb" {
    value = "${azurerm_public_ip.preview_publicip_lb.ip_address}"
}
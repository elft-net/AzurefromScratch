### OUTPUTS

output "vm_name" {
  value = azurerm_virtual_machine.pm-labs.name
}

output "vm_internalip" {
  value = azurerm_network_interface.pm-labs.private_ip_address
}

output "vm_publicip" {
  value = azurerm_public_ip.pm-labs.ip_address
}

output "vm_publicdns" {
  value = "${var.env_name}-direct.westeurope.cloudapp.azure.com"
}



# EOF


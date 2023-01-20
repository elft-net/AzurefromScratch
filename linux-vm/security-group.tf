## Front-End Security Group

# Trick to guarantee that we can access the target VM
data "external" "client_ip" {
  program = ["curl", "https://api.ipify.org/?format=json"]
}

resource "azurerm_network_security_group" "pm-labs" {
  name                = "${var.env_name}-sg"
  location            = azurerm_resource_group.pm-labs.location
  resource_group_name = azurerm_resource_group.pm-labs.name
}

resource "azurerm_network_security_rule" "pm-labs_http_in" {
  name                        = "${var.env_name}-http-in"
  priority                    = "200"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = element(azurerm_subnet.pm-labs.address_prefixes,1)
  resource_group_name         = azurerm_resource_group.pm-labs.name
  network_security_group_name = azurerm_network_security_group.pm-labs.name
}

resource "azurerm_network_security_rule" "pm-labs_https_in" {
  name                        = "${var.env_name}-https-in"
  priority                    = "210"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = element(azurerm_subnet.pm-labs.address_prefixes, 1)
  resource_group_name         = azurerm_resource_group.pm-labs.name
  network_security_group_name = azurerm_network_security_group.pm-labs.name
}

resource "azurerm_network_security_rule" "pm-labs_ssh_in" {
  name                        = "${var.env_name}-ssh-in"
  priority                    = "230"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = data.external.client_ip.result["ip"]
  destination_address_prefix  = element(azurerm_subnet.pm-labs.address_prefixes, 1)
  resource_group_name         = azurerm_resource_group.pm-labs.name
  network_security_group_name = azurerm_network_security_group.pm-labs.name
}

resource "azurerm_network_security_rule" "pm-labs_any_out" {
  name                        = "${var.env_name}-any-out"
  priority                    = "300"
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = element(azurerm_subnet.pm-labs.address_prefixes, 1)
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.pm-labs.name
  network_security_group_name = azurerm_network_security_group.pm-labs.name
}

# EOF #


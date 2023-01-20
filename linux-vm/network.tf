### NETWORKING

resource "azurerm_public_ip" "pm-labs" {
  name                = "${var.env_name}-publicip"
  location            = azurerm_resource_group.pm-labs.location
  resource_group_name = azurerm_resource_group.pm-labs.name
  allocation_method   = "Static"
  domain_name_label   = "${var.env_name}-direct"

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_virtual_network" "pm-labs" {
  name                = "${var.env_name}-net"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.pm-labs.location
  resource_group_name = azurerm_resource_group.pm-labs.name

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_subnet" "pm-labs" {
  name                 = "${var.env_name}-subnet"
  resource_group_name  = azurerm_resource_group.pm-labs.name
  virtual_network_name = azurerm_virtual_network.pm-labs.name
  address_prefixes     = tolist([cidrsubnet(element(azurerm_virtual_network.pm-labs.address_space, 1), 8, 1)])
}

# EOF


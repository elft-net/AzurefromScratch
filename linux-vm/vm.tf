### Front-End Research VM

resource "azurerm_network_interface" "pm-labs" {
  name                = "${var.env_name}-nic"
  location            = azurerm_resource_group.pm-labs.location
  resource_group_name = azurerm_resource_group.pm-labs.name

  ip_configuration {
    name                          = "ip-config"
    subnet_id                     = azurerm_subnet.pm-labs.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(element(azurerm_subnet.pm-labs.address_prefixes, 1), 5)
    public_ip_address_id          = azurerm_public_ip.pm-labs.id
  }

  tags = {
    environment = var.env_name
  }
}

# data "azurerm_key_vault" "demo" {
#  name                = "tf-azure-demo"
#  resource_group_name = "tf-demo"
#}

# data "azurerm_key_vault_secret" "pm-labs_publickey" {
#   name         = "vm-admin-publickey"
#   key_vault_id = data.azurerm_key_vault.mos.id
# }

resource "azurerm_virtual_machine" "pm-labs" {
  name                             = "${var.env_name}-vm"
  location                         = azurerm_resource_group.pm-labs.location
  resource_group_name              = azurerm_resource_group.pm-labs.name
  network_interface_ids            = [azurerm_network_interface.pm-labs.id]
  vm_size                          = var.vm_size
  delete_os_disk_on_termination    = true # CAVEAT: this is ok for demoing, a VERY BAD idea otherwise
  delete_data_disks_on_termination = true # CAVEAT: this is ok for demoing, a VERY BAD idea otherwise

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.env_name}-osdisk"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  storage_data_disk {
    name          = "${var.env_name}-datadisk"
    create_option = "Empty"
    lun           = 0
    disk_size_gb  = "10"
  }

  os_profile {
    computer_name  = "tf-azure-vm"
    admin_username = var.vm_admin_username
    custom_data    = file("init-script.sh")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path        = "/home/${var.vm_admin_username}/.ssh/authorized_keys"
      key_data    = file("~/.ssh/id_rsa.pub")
#      key_data    = data.azurerm_key_vault_secret.pm-labs_publickey.value
    }
  }

  tags = {
    environment = var.env_name
  }
}

# EOF


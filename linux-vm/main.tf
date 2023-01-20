### MAIN

terraform {
  # required_version = "~> 0.12"

  backend "azurerm" {
    resource_group_name  = "AzurefromScratch"
    storage_account_name = "scratchvault"
    container_name       = "tf-state"
    key                  = "linux-vm-terraform.tfstate"
  }
}

provider "azurerm" {
   #   version = "~> 1.0"
   features {}
}

# provider "external" {
#   version = "~> 1.0"
# }

resource "azurerm_resource_group" "pm-labs" {
  name     = "pm-labs-${var.env_name}"
  location = var.resource_group_location

  tags = {
    environment = var.env_name
  }
}

# EOF


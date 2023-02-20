provider "azurerm" {
  version = "2.0.0"
  features {}
}

resource "azurerm_resource_group" "group" {
  name     = "ChatbotResourceGroup"
  location = "northcentralus"
}

resource "azurerm_cosmosdb_account" "db" {
  name                = "ChatbotDatabase"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  offer_type     = "Standard"
  kind           = "GlobalDocumentDB"
  consistency_policy {
    consistency_level = "Session"
  }

  enable_automatic_failover = false
}

resource "azurerm_bot_channels_registration" "bot" {
 name                = "ChatbotAppName"
 location            = azurerm_resource_group.group.location
 resource_group_name = azurerm_resource_group.group.name

 kind               = "sdk"
 language           = "csharp"
 microsoft_app_id   = ""
 sku_name           = "F0"
 microsoft_app_password = ""
}

resource "azurerm_app_service_plan" "web" {
  name                = "ChatbotAppServicePlan"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name

  kind = "FunctionApp"
  sku {
   tier = "Dynamic"
  }
}

resource "azurerm_function_app" "function" {
  name                      = "ChatbotFunctionApp"
  location                  = azurerm_resource_group.group.location
  resource_group_name       = azurerm_resource_group.group.name
  app_service_plan_id       = azurerm_app_service_plan.web.id

  version = 5

  app_settings {
    "func.botfile" = <<EOF
	{
	  "bot_id": "ChatbotAppName",
	  "endpoint": "https://ChatbotAppName.azurewebsites.net/api/messages",
	  "endpoint_key": "ChatbotAppPassword",
	  "msteams": {},
	  "skype": {},
	  "slack": {},
	  "teams": {},
	  "webchat": {
		"secret": "Pass@word"
	  }
	}
EOF


  }
 connection {
  name                  = "chatbot_cosmosdb"
  type                  = "CosmosDB"
  app_settings {
      connectionString = azurerm_cosmosdb_account.db.connection_strings.0.connection_string
  }
}

storage_account_name     = azurerm_cosmosdb_account.db.name
container_name           = "botstate"
}

output "link" {
  value = azurerm_bot_channels_registration.bot.endpoint
}

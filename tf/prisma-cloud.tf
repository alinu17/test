variable "client_secret" {
}

provider "azurerm" {
  version = "=2.0.0"

  subscription_id = "6703da71-609b-4f29-a136-5c0244f6301d"
  client_id       = "84dc53d9-2e56-4b77-a8e3-8367ad11f413"
  client_secret   = var.client_secret
  tenant_id       = "0efbbc6f-42ae-40a8-bf9b-d21494fb46b7"

  features {}
}


resource "azurerm_resource_group" "prisma-cloud" {
  name     = "prisma-cloud-rg"
  location = "East US"

  tags = {
    owner       = "Alin Ungurean"
    application = "Prisma Cloud"
    environment = "poc"
  }
}


resource "azurerm_storage_account" "prisma-cloud" {
  name = "prismacloudpocstorage"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = ["173.32.53.65"]
  }

#  queue_properties {
#    logging {
#      delete  = true
#      read    = true
#      version = "true"
#      write   = true
#    }
#  }

  resource_group_name      = azurerm_resource_group.prisma-cloud.name
  location                 = azurerm_resource_group.prisma-cloud.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    owner       = "Alin Ungurean"
    application = "Prisma Cloud"
    environment = "poc"
  }
}
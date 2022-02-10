terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id   = "5a8f9104-036d-4ab0-ac8e-31427f3ff172"
  tenant_id         = "6e31e5da-0ac2-47ce-8189-c84c41fa12fe"
  client_id         = "7e893063-8a9c-4caf-be0c-ec5e59e8ba30"
  client_secret     = "ubE_aNMirT.mRd89m81ghqxAvbo_~221oz"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location  
  allow_blob_public_access = false
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only    = false  
  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
  //  virtual_network_subnet_ids = [azurerm_subnet.example.id]    
  bypass = ["log"]
 }
}

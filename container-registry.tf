resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  name = "registry-uai"
}

resource "azurerm_container_registry" "iac-acr-violation" {
  name                = "containerRegistryiac"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
  admin_enabled       = true
  public_network_access_enabled = true

  encryption  {
    enabled            = true
    key_vault_key_id   = "mehul123"
    identity_client_id = azurerm_user_assigned_identity.example.client_id
  }
  
}

resource "azurerm_container_registry" "iac-acr-positive" {
  name                = "containerRegistry1"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
  admin_enabled       = false
  public_network_access_enabled = false
  
  identity  {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.example.id
    ]
  }
  encryption {
    enabled            = true
    key_vault_key_id   = "mehul123"
    identity_client_id = azurerm_user_assigned_identity.example.client_id
  }

  network_rule_set {
      default_action = "Deny"
     
      ip_rule = [
      {
        action   = "Allow"
        ip_range = "49.204.225.49/32"
      }
    ]
   }

  tags = {
    iac = "acr-positive"
  }
}
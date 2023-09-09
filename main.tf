provider "azurerm" {
  features {}
  use_oidc             = true
  client_id_file_path  = var.tfc_azure_dynamic_credentials.default.client_id_file_path
  oidc_token_file_path = var.tfc_azure_dynamic_credentials.default.oidc_token_file_path
}

provider "azurerm" {
  features {}
  subscription_id      = var.security_subscription_id
  tenant_id            = var.security_tenant_id
  alias                = "security"
  use_oidc             = true
  client_id_file_path  = var.tfc_azure_dynamic_credentials.aliases["security"].client_id_file_path
  oidc_token_file_path = var.tfc_azure_dynamic_credentials.aliases["security"].oidc_token_file_path
}

locals {
  base_name = "${var.prefix}web"
}

resource "azurerm_resource_group" "web" {
  name     = local.base_name
  location = var.location

  tags = {
    environment = var.prefix
  }
}

resource "azurerm_resource_group" "security" {
  provider = azurerm.security
  name     = "${local.base_name}-security"
  location = var.location

  tags = {
    environment = var.prefix
    security    = "true"
  }
}

resource "azurerm_virtual_network" "web" {
  name                = local.base_name
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location

  address_space = [var.address_space]

  tags = {
    "environment" = var.prefix
  }
}

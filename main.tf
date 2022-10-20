variable "prefix" {
  type        = string
  description = "(Required) Naming prefix for resources."
}

variable "address_space" {
  type        = string
  description = "(Optional) Address space for virtual network, defaults to 10.0.0.0/16."
  default     = "10.1.0.0/16"
}

variable "location" {
  type        = string
  description = "(Optional) Region for Azure resources, defaults to East US."
  default     = "eastus"
}

locals {
  base_name = "${var.prefix}web"
  change = "trigger-08032022"
}

resource "azurerm_resource_group" "web" {
  name     = local.base_name
  location = var.location
  
  tags = {
    "environment" = var.prefix
    "owner" = "clippy"
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

locals {
  change = "trigger a change"
}

/// This is a pain in the ass

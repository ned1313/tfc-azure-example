variable "prefix" {
  type        = string
  description = "(Required) Naming prefix for resources."
}

variable "address_space" {
  type        = string
  description = "(Optional) Address space for virtual network, defaults to 10.0.0.0/16."
  default     = "10.0.0.0/16"
}

variable "location" {
  type        = string
  description = "(Optional) Region for Azure resources, defaults to East US."
  default     = "eastus"
}

locals {
  base_name = "${var.prefix}web"
  change = "trigger a change"
}

resource "azurerm_resource_group" "web" {
  name     = local.base_name
  location = var.location
  
  tags = {
    "environment" = var.prefix
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


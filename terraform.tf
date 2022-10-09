terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    environment = {
      source  = "EppO/environment"
      version = "~>1.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  oidc_token = data.environment_variables.all.items["TFC_WORKLOAD_IDENTITY_TOKEN"]
}


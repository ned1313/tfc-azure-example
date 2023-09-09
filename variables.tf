variable "prefix" {
  type        = string
  description = "(Required) Naming prefix for resources."
}

variable "address_space" {
  type        = string
  description = "(Optional) Address space for virtual network, defaults to 10.0.0.0/16."
  default     = "10.42.0.0/16"
}

variable "location" {
  type        = string
  description = "(Optional) Region for Azure resources, defaults to East US."
  default     = "eastus"
}

variable "tfc_azure_dynamic_credentials" {
  description = "Object containing Azure dynamic credentials configuration"
  type = object({
    default = object({
      client_id_file_path  = string
      oidc_token_file_path = string
    })
    aliases = map(object({
      client_id_file_path  = string
      oidc_token_file_path = string
    }))
  })
}
variable "security_subscription_id" {
  description = "Subscription ID for security resources"
  type        = string
}

variable "security_tenant_id" {
  description = "Tenant ID for security resources"
  type        = string
}
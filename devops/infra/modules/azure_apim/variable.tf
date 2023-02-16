variable "resource_group_name" {
  type        = string
  description = "Resource Group name in Azure"
}

variable "apim_instance_name" {
  type        = string
  description = "Api management instance name in Azure"
}

variable "publisher_name" {
  type        = string
  description = "Name of publisher who publishes this apim instance"
}

variable "publisher_email" {
  type        = string
  description = "Email of publisher who publishes this apim instance"
}

variable "api_name" {
  type        = string
  description = "Api name in Azure apim in Azure"
}

variable "azurerm_function_app_host_key" {
  type        = string
  description = "Host key of Azure Function App used by Azure API management for connection"
}

variable "azurerm_function_name_out" {
  type        = string
  description = "Azure function app name used in azure api management"
}

variable "operation_id" {
  type        = string
  description = "operation id in Azure api management api operations."
}

variable "function_app_resource_id" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name in Azure"
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account name in Azure"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service plan name in Azure"
}

variable "function_app_name" {
  type        = string
  description = "Azure Function App name"
}

variable "connection_string_name" {
  type        = string
  description = "Connection String Name in Azure"
}

variable "connection_string_type" {
  type        = string
  description = "Connection String Type in Azure"
}

variable "account_tier" {
  type        = string
  description = "Account Tier for Azure Storage Account in Azure"
}

variable "account_replication_type" {
  type        = string
  description = "Account Replication Type for Azure Storage Account in Azure"
}

variable "kind_sp" {
  type        = string
  description = "Azure App Service Plan kind"
}

variable "reserved_sp" {
  type        = string
  description = "App Service Plan type for reserved."
}

variable "sku_tier" {
  type        = string
  description = "sku type in App Service plan in Azure"
}

variable "sku_size" {
  type        = string
  description = "sku size in App Service Plan in Azure"
}

variable "os_type" {
  type        = string
  description = "operating system for Function App in Azure"
}

variable "endpoint" {
  type = string
}

variable "primary_key" {
  type = string
}
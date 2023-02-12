variable "resource_group_name" {
  type        = string
  description = "Resource Group name in Azure"
}

variable "cosmosdb_acc_name" {
  type        = string
  description = "cosmosdb account name"
}

variable "cosmosdb_name" {
  type        = string
  description = "mongodb name in Azure Cosmos Db"
}

variable "collection_name" {
  type        = string
  description = "collection name in Mongo Db"
}
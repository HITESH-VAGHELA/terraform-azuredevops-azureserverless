#Module Blocks
module "terraform-module-function-app" {
  source                   = "./modules/azure_function_app/"
  resource_group_name      = var.resource_group_name
  storage_account_name     = var.storage_account_name
  app_service_plan_name    = var.app_service_plan_name
  function_app_name        = var.function_app_name
  connection_string_name   = var.connection_string_name
  connection_string_type   = var.connection_string_type
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  kind_sp                  = var.kind_sp
  reserved_sp              = var.reserved_sp
  sku_tier                 = var.sku_tier
  sku_size                 = var.sku_size
  os_type                  = var.os_type
  endpoint                 = module.terraform-module-cosmosdb.azurerm_cosmosdb_endpoint
  primary_key              = module.terraform-module-cosmosdb.azurerm_cosmosdb_primary_key
}

module "terraform-module-cosmosdb" {
  source              = "./modules/azure_cosmosdb/"
  resource_group_name = var.resource_group_name
  cosmosdb_acc_name   = var.cosmosdb_acc_name
  cosmosdb_name       = var.cosmosdb_name
  collection_name     = var.collection_name
}

module "terraform-module-apim" {
  source                        = "./modules/azure_apim/"
  resource_group_name           = var.resource_group_name
  apim_instance_name            = var.apim_instance_name
  publisher_name                = var.publisher_name
  publisher_email               = var.publisher_email
  api_name                      = var.api_name
  operation_id                  = var.operation_id
  azurerm_function_app_host_key = module.terraform-module-function-app.azurerm_function_app_host_key
  azurerm_function_name_out     = module.terraform-module-function-app.azurerm_function_name_out
}
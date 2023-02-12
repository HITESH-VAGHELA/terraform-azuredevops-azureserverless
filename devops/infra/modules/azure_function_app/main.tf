data "azurerm_resource_group" "zymr-resource-group" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "zymr-storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.zymr-resource-group.name
  location                 = data.azurerm_resource_group.zymr-resource-group.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_service_plan" "zymr-app-service-plan" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.zymr-resource-group.location
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  os_type             = var.kind_sp
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "zymr-function-app" {
  name                       = var.function_app_name
  location                   = data.azurerm_resource_group.zymr-resource-group.location
  resource_group_name        = data.azurerm_resource_group.zymr-resource-group.name
  service_plan_id            = azurerm_service_plan.zymr-app-service-plan.id
  storage_account_name       = azurerm_storage_account.zymr-storage-account.name
  storage_account_access_key = azurerm_storage_account.zymr-storage-account.primary_access_key

  site_config {}

  app_settings = {
    shdevdb_DOCUMENTDB = "AccountEndpoint=${var.endpoint};AccountKey=${var.primary_key};"
  }
  connection_string {
    name  = var.connection_string_name
    type  = var.connection_string_type
    value = "AccountEndpoint=${var.endpoint};AccountKey=${var.primary_key};"
  }
}

#data "azurerm_function_app_host_keys" "func_key" {
#  name                = azurerm_linux_function_app.zymr-function-app.name
#  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
#  depends_on          = [azurerm_linux_function_app.zymr-function-app]
#}

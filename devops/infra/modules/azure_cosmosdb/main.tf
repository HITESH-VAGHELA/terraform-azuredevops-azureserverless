data "azurerm_resource_group" "zymr-resource-group" {
  name = var.resource_group_name
}

resource "azurerm_cosmosdb_account" "zymr-cosmos-db" {
  name                = "${var.cosmosdb_acc_name}-${terraform.workspace}"
  location            = data.azurerm_resource_group.zymr-resource-group.location
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  offer_type          = "Standard"

  enable_automatic_failover = false

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  geo_location {
    location          = "westus"
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "zymr-cosmosdb-sql" {
  name                = var.cosmosdb_name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  account_name        = azurerm_cosmosdb_account.zymr-cosmos-db.name
}

resource "azurerm_cosmosdb_sql_container" "zymr-cosmos-container" {
  name                = var.collection_name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  account_name        = azurerm_cosmosdb_account.zymr-cosmos-db.name
  database_name       = azurerm_cosmosdb_sql_database.zymr-cosmosdb-sql.name
  partition_key_path  = "/userId"
}
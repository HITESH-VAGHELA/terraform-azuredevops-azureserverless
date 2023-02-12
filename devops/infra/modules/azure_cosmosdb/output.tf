output "azurerm_cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.zymr-cosmos-db.endpoint
}

output "azurerm_cosmosdb_primary_key" {
  value = azurerm_cosmosdb_account.zymr-cosmos-db.primary_key
}
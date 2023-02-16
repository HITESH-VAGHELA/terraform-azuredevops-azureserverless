output "azurerm_function_app_host_key" {
  value     = module.terraform-module-function-app.azurerm_function_app_host_key
  sensitive = true
}

output "azurerm_function_name_out" {
  value = module.terraform-module-function-app.azurerm_function_name_out
}


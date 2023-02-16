#output "azurerm_function_app_host_key" {
#  value     = data.azurerm_function_app_host_keys.func_key.default_function_key
#  sensitive = true
#}
#
#output "azurerm_function_name_out" {
#  value = azurerm_linux_function_app.zymr-function-app.name
#}
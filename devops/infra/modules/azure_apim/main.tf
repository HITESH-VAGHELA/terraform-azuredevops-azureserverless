data "azurerm_resource_group" "zymr-resource-group" {
  name = var.resource_group_name
}

resource "azurerm_api_management" "zymr-apim-instance" {
  name                = "${var.apim_instance_name}-${terraform.workspace}"
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  location            = data.azurerm_resource_group.zymr-resource-group.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "Consumption_0"
}

resource "azurerm_api_management_api" "zymr-api" {
  name                  = var.api_name
  api_management_name   = azurerm_api_management.zymr-apim-instance.name
  resource_group_name   = data.azurerm_resource_group.zymr-resource-group.name
  revision              = "1"
  display_name          = "ToDo Api"
  protocols             = ["https"]
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "zymr-api-management-operation-todo-get" {
  operation_id        = "${var.operation_id}-get"
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  display_name        = "ToDoApi endpoint"
  method              = "GET"
  url_template        = "/users/${var.operation_id}-get/get"
  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "zymr-api-management-operation-todo-post" {
  operation_id        = "${var.operation_id}-post"
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  display_name        = "ToDoApi endpoint"
  method              = "POST"
  url_template        = "/users/${var.operation_id}-post/post"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "zymr-api-management-operation-todo-put" {
  operation_id        = "${var.operation_id}-post"
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  display_name        = "ToDoApi endpoint"
  method              = "POST"
  url_template        = "/users/${var.operation_id}-post/post"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "zymr-api-management-operation-todo-delete" {
  operation_id        = "${var.operation_id}-delete"
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  display_name        = "ToDoApi endpoint"
  method              = "DELETE"
  url_template        = "/users/${var.operation_id}-delete/delete"

  response {
    status_code = 200
  }
}

# Adds the function app as a backend for the API.
resource "azurerm_api_management_backend" "zymr-azure-apim-backend" {
  name                = var.azurerm_function_name_out
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  protocol            = "http"
  url                 = "https://${var.azurerm_function_name_out}.azurewebsites.net/api/"
  credentials {
    certificate = []
    header = {
      "x-functions-key" = "${var.azurerm_function_app_host_key}"
    }
  }
}

# Adds a policy that routes REST calls to the function app.
resource "azurerm_api_management_api_policy" "zymr-apim-api-policy" {
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name

  xml_content = <<XML
<policies>
    <inbound>
        <base />
        <set-backend-service id="apim-generated-policy" backend-id="${azurerm_api_management_backend.zymr-azure-apim-backend.name}" />
    </inbound>
</policies>
XML
}
resource "azurerm_api_management_api_operation_policy" "todo-POST" {
  api_name            = azurerm_api_management_api.zymr-api.name
  api_management_name = azurerm_api_management.zymr-apim-instance.name
  resource_group_name = data.azurerm_resource_group.zymr-resource-group.name
  operation_id        = azurerm_api_management_api_operation.zymr-api-management-operation-todo-post.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <base/>
    <set-backend-service id="apim-generated-policy" backend-id="${azurerm_api_management_backend.zymr-azure-apim-backend.name}}" />
  </inbound>
</policies>
XML
}
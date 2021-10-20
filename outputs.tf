output "databricks_workspace_private_endpoint_connection_workspace_id" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].workspace_id : ""
}

output "databricks_workspace_private_endpoint_connection_private_endpoint_id" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].private_endpoint_id : ""
}

output "databricks_workspace_private_endpoint_connection_name" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].connections.0.name : ""
}

output "databricks_workspace_private_endpoint_connection_workspace_private_endpoint_id" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].connections.0.workspace_private_endpoint_id : ""
}

output "databricks_workspace_private_endpoint_connection_status" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].connections.0.status : ""
}

output "databricks_workspace_private_endpoint_connection_description" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].connections.0.description : ""
}

output "databricks_workspace_private_endpoint_connection_action_required" {
  value = var.private_networking ? data.azurerm_databricks_workspace_private_endpoint_connection.example[0].connections.0.action_required : ""
}
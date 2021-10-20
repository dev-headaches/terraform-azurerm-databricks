data "azurerm_databricks_workspace_private_endpoint_connection" "example" {
  depends_on          = [azurerm_private_endpoint.databricks[0]]
  count = var.private_networking ? 1:0
  workspace_id        = azurerm_databricks_workspace.example.id
  private_endpoint_id = azurerm_private_endpoint.databricks[0].id
}
resource "azurerm_network_security_group" "example" {
  name                = "nsg_databricks_${var.prjnum}"
  location            = var.location
  resource_group_name = var.netsec_rgname 
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = var.databricks_private_subnet_id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = var.databricks_public_subnet_id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_databricks_workspace" "example" {
  name                = "DBW_${var.prjnum}"
  resource_group_name = var.dataops_rgname
  location            = var.location
  sku                 = "premium"
  managed_resource_group_name = "rg_databricks_managed_${var.prjnum}"
  public_network_access_enabled = var.private_networking ? false : true
  network_security_group_rules_required = var.private_networking ? "NoAzureDatabricksRules" : "AllRules"
  
  #customer_managed_key_enabled = true
  infrastructure_encryption_enabled = true
    
  custom_parameters {
    no_public_ip = var.private_networking ? true : false
    virtual_network_id = var.vnet_id
    public_subnet_name = var.databricks_public_subnet_id
    private_subnet_name = var.databricks_private_subnet_id
    public_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }
  
  tags = {
    Environment = "tst"
  }
}

resource "azurerm_private_endpoint" "databricks" {
  count = var.private_networking ? 1:0
  name                = "pe_databricks_${var.prjnum}"
  location            = var.location
  resource_group_name = var.network_rgname
  subnet_id           = var.endpoint_subnet_id

  private_service_connection {
    name                           = "psc_${var.prjnum}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.example.id
    subresource_names              = ["databricks_ui_api"]
  }
}

resource "azurerm_private_dns_zone" "example" {
  count = var.private_networking ? 1:0
  depends_on = [azurerm_private_endpoint.databricks[0]]

  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.network_rgname
}

resource "azurerm_private_dns_cname_record" "example" {
  count = var.private_networking ? 1:0
  name                = azurerm_databricks_workspace.example.workspace_url
  zone_name           = azurerm_private_dns_zone.example[0].name
  resource_group_name = var.network_rgname
  ttl                 = 300
  record              = "usgovvirginia.databricks.azure.us"
}
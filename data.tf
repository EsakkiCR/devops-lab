data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_network_security_group" "existing" {
  name                = azurerm_network_security_group.devops_lab.name
  resource_group_name = var.resource_group_name
}

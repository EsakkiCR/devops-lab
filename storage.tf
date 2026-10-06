resource "azurerm_storage_account" "devops_lab" {
  name                     = "stdevopslab0510"
  resource_group_name      = azurerm_resource_group.devops_lab.name
  location                 = azurerm_resource_group.devops_lab.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.common_tags
}

resource "azurerm_storage_container" "devops_files" {
  name                  = "devops-files"
  storage_account_id    = azurerm_storage_account.devops_lab.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "count-demo" {
  count                 = 4
  name                  = "demo-${count.index}"
  storage_account_id    = azurerm_storage_account.devops_lab.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "new-demo" {
  count                 = var.container_count
  name                  = "new-demo-${count.index + 1}"
  storage_account_id    = azurerm_storage_account.devops_lab.id
  container_access_type = "private"
}

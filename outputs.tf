output "vm_name" {
  description = "Name of the azure vm"
  value       = azurerm_linux_virtual_machine.devops-lab.name
}

output "vm_public_ip" {
  description = "Public IP address of Azure VM"
  value       = azurerm_linux_virtual_machine.devops-lab.public_ip_address
}

output "vm_private_ip" {
  description = "Private IP address of Azure VM"
  value       = azurerm_linux_virtual_machine.devops-lab.private_ip_address
}

output "existing_rg_location" {
  description = "Location read from the existing resource group"
  value       = data.azurerm_resource_group.existing.location
}

output "existing_nsg_name" {
  description = "Name of Azure network security group"
  value       = data.azurerm_network_security_group.existing.name
}

output "existing_blob_container_name" {
  description = "Name of Azure Storage Blob container name"
  value       = azurerm_storage_container.devops_files.name
}

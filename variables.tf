variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "South India"
}

variable "vm_size" {
  description = "Azure VM Size"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "resource_group_name" {
  description = "Name of Azure resource group"
  type        = string
  default     = "rg-devops-lab"
}

variable "vnet_name" {
  description = "Name of Azure virtual network"
  type        = string
  default     = "vnet-devops-lab"
}

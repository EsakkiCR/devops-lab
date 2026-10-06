resource "azurerm_resource_group" "devops_lab" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "devops_lab" {
  name                = var.vnet_name
  location            = azurerm_resource_group.devops_lab.location
  resource_group_name = azurerm_resource_group.devops_lab.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.devops_lab.name
  virtual_network_name = azurerm_virtual_network.devops_lab.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "devops_lab" {
  name                = "nsg-devops-lab"
  location            = azurerm_resource_group.devops_lab.location
  resource_group_name = azurerm_resource_group.devops_lab.name
}


resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops_lab.name
  network_security_group_name = azurerm_network_security_group.devops_lab.name
}


resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow-http"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.devops_lab.name
  network_security_group_name = azurerm_network_security_group.devops_lab.name
}


resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.devops_lab.id
}

resource "azurerm_public_ip" "devops_lab" {
  name                = "pip-devops-lab"
  location            = azurerm_resource_group.devops_lab.location
  resource_group_name = azurerm_resource_group.devops_lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "devops_lab" {
  name                = "nic-devops-lab"
  location            = azurerm_resource_group.devops_lab.location
  resource_group_name = azurerm_resource_group.devops_lab.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.devops_lab.id

  }
}


resource "azurerm_linux_virtual_machine" "devops-lab" {
  name                = "vm-devops-lab"
  location            = azurerm_resource_group.devops_lab.location
  resource_group_name = azurerm_resource_group.devops_lab.name
  size                = var.vm_size

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.devops_lab.id
  ]

  disable_password_authentication = true
  admin_ssh_key {
    username   = "azureuser"
    public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

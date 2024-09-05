# Define variáveis para a localização e outros parâmetros
variable "location" {
  default = "West US 2"
}

variable "admin_password" {
  description = "Senha para o administrador da máquina virtual"
  type        = string
  sensitive   = true
}

# Define um grupo de recursos chamado "projeto_giovaninexus"
resource "azurerm_resource_group" "projeto_giovaninexus" {
  name     = "Grupo_Recursos_Projeto3"
  location = var.location

  tags = {
    Environment = "Development"
    Project     = "giovaninexus"
  }
}

# Cria uma rede virtual chamada "giovaninexus_vnet"
resource "azurerm_virtual_network" "giovaninexus_vnet" {
  name                = "vnet_terr_giovaninexus"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.projeto_giovaninexus.location
  resource_group_name = azurerm_resource_group.projeto_giovaninexus.name

  tags = {
    Environment = "Development"
    Project     = "giovaninexus"
  }
}

# Cria a subnet dentro da rede virtual (os recursos de rede ficam na subnet)
resource "azurerm_subnet" "giovaninexus_subnet1" {
  name                 = "subnet_terr_giovaninexus"
  resource_group_name  = azurerm_resource_group.projeto_giovaninexus.name
  virtual_network_name = azurerm_virtual_network.giovaninexus_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  tags = {
    Environment = "Development"
    Project     = "giovaninexus"
  }
}

# Cria uma interface de rede para a máquina virtual
resource "azurerm_network_interface" "giovaninexus_ni" {
  name                = "ni_terr_giovaninexus"
  location            = azurerm_resource_group.projeto_giovaninexus.location
  resource_group_name = azurerm_resource_group.projeto_giovaninexus.name

  # Configuração de IP para a interface de rede
  ip_configuration {
    name                          = "vm_giovaninexus"
    subnet_id                     = azurerm_subnet.giovaninexus_subnet1.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = "Development"
    Project     = "giovaninexus"
  }
}

# Cria uma máquina virtual Linux
resource "azurerm_linux_virtual_machine" "giovaninexus_vm" {
  name                = "vmgiovaninexus"
  resource_group_name = azurerm_resource_group.projeto_giovaninexus.name
  location            = azurerm_resource_group.projeto_giovaninexus.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = false
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.giovaninexus_ni.id]

  # Configurações do disco para o sistema operacional
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Imagem do sistema operacional da máquina virtual
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = {
    Environment = "Development"
    Project     = "giovaninexus"
  }
}
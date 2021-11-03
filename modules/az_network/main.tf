# Get data for existing Resource Group
data "azurerm_resource_group" "rg" {
  name = var.network_RG_name
}

# Get data for existing Vnet
data "azurerm_virtual_network" "vnet" {
  name = var.network_vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Get data for existing subnet
data "azurerm_subnet" "subnet1" {
    name = var.network_subnet_name
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name = data.azurerm_resource_group.rg.name
}

# create Public IP address
resource "azurerm_public_ip" "public_ip_1" {
  name = "haszbro_public_ip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  allocation_method = "Static"

  tags = {
    project     = var.tag_project
    environment = var.tag_environment
    comments    = var.tag_comments
  }
}
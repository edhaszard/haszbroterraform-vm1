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
#data "azurerm_resource_group" "VM_rg" {
##    name = var.VM_rg
#}

#data "azurerm_resource_group" "ASR_rg" {
#    name = var.ASR_rg
#}

resource "azurerm_recovery_services_vault" "vault" {
    name = "rv-test-${data.azurerm_resource_group.ASR_rg.location}"
    location = var.ASR_rg_location
    resource_group_name = data.azurerm_resource_group.ASR_rg.name
    sku = var.ASR_sku
}
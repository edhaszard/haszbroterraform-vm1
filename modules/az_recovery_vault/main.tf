data "azurerm_resource_group" "VM_rg" {
    name = var.resource_group_VMresourceGroup
}

data "azurerm_resource_group" "ASR_rg" {
    name = var.resource_group_ASRresourcegroup
}

resource "azurerm_recovery_services_vault" "vault" {
    name = "rv-test-${data.azurerm_resource_group.ASR_rg.location}"
    location = data.azurerm_resource_group.ASR_rg.location
}
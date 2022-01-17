resource "azurerm_recovery_services_vault" "vault" {
    name = "rv-test-${data.azurerm_resource_group.ASR_rg.location}"
    location = data.azurerm_resource_group.ASR_rg.location
    resource_group_name = data.azurerm_resource_group.ASR_rg.name
    sku = var.ASR_sku
}
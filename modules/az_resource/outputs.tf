output "location" {
  value = azurerm_resource_group.rg.location
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "tag_deployment" {
  value = avar.tag_deployment
}
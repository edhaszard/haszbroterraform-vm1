output "mdisk_d_id" {
    value = azurerm_managed_disk.mdisk.id
}

output "subnet1_id" {
  value = data.azurerm_subnet.subnet1.id
}
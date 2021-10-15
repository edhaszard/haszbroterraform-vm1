# subnet outputs
output "subnet1_id" {
  value = data.azurerm_subnet.subnet1.id
}

output "subnet1_name" {
  value = data.azurerm_subnet.subnet1.name
}
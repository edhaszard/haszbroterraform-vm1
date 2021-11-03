# subnet outputs
output "subnet1_id" {
  value = data.azurerm_subnet.subnet1.id
}

output "subnet1_name" {
  value = data.azurerm_subnet.subnet1.name
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip_1.id
}
### Create data disk for VM
resource "azurerm_managed_disk" "mdisk" {
    name = var.mdisk_name
    location = var.location
    resource_group_name = var.resource_group_name
    storage_account_type = var.storage_account_type
    create_option = var.mdisk_create_option
    disk_size_gb = var.mdisk_size_gb
}
##########################################################
## Create NICs for VM
##########################################################
resource "azurerm_network_interface" "net_if" {
  #count               = var.vm_count
  location            = var.location
  name                = "${var.vm_name}-nic"
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfmain"
    subnet_id                     = var.vm_subnet
    private_ip_address_allocation = "Dynamic"
    #private_ip_address = "${var.ip_address_range}${count.index + 6}"
  }
  tags = {
    project     = var.tag_project
    environment = var.tag_environment
    comments    = var.tag_comments
    deployment  = var.tag_deployment
  }
}


##########################################################
## Create Windows VM
##########################################################
resource "azurerm_windows_virtual_machine" "vm" {
  name                             = var.vm_name
  #count                            = var.vm_count
  location                         = var.location
  resource_group_name              = var.resource_group_name
  size                             = var.vm_size
  admin_username                   = var.vm_admin_username
  admin_password                   = var.vm_admin_password
  network_interface_ids            = [azurerm_network_interface.net_if.id]
  #availability_set_id              = var.avset_id
  # delete_data_disks_on_termination = true

  source_image_reference {
    offer     = var.vm_storage_img_offer
    publisher = var.vm_storage_img_publisher
    sku       = var.vm_storage_img_sku
    version   = "latest"
  ### Reference to custom image
    # id = data.azurerm_image.vmimage.id
  }

  os_disk {
    name              = "${var.vm_name}-os"
    storage_account_type = var.storage_account_type
    caching           = "ReadWrite"
  }
  
  tags = {
    project     = var.tag_project
    environment = var.tag_environment
    comments    = var.tag_comments
    deployment  = var.tag_deployment
  }

}

# ##########################################################
# ### Attach managed disk(s) to VM
# ##########################################################
resource "azurerm_virtual_machine_data_disk_attachment" "attdisk1" {
  lun = 1
  managed_disk_id = var.mdisk_1_id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  caching = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "attdisk2" {
  lun = 1
  managed_disk_id = var.mdisk_2_id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  caching = "ReadWrite"
}

# ##########################################################
# ### Azure Monitoring Agent
# ##########################################################
# resource "azurerm_virtual_machine_extension" "vmagent" {
#   count                = var.vm_count
#   name                 = "MicrosoftMonitoringAgent"
#   virtual_machine_id   = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
#   publisher            = "Microsoft.EnterpriseCloud.Monitoring"
#   type                 = "MicrosoftMonitoringAgent"
#   type_handler_version = "1.0"
#   depends_on           = [azurerm_windows_virtual_machine.vm]
#   settings = <<SETTINGS
#   {
#     "workspaceId": "bc7dd49a-2206-461c-9164-619c6471eca2"
#   }
#   SETTINGS

#   protected_settings = <<PROTECTED_SETTINGS
#     {
#         "workspaceKey": "${var.workspace_key}"
#     }
# PROTECTED_SETTINGS
# }


# ##########################################################
# ## Join VM to domain
# ##########################################################
# resource "azurerm_virtual_machine_extension" "adjoin" {
#   count                = var.vm_count
#   name                 = "join-domain"
#   virtual_machine_id   = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
#   publisher            = "Microsoft.Compute"
#   type                 = "JsonADDomainExtension"
#   type_handler_version = "1.3"
#   depends_on           = [azurerm_windows_virtual_machine.vm]

#   settings = <<SETTINGS
#     {
#         "Name": "ihc.co.nz",
#         "OUPath": "OU=Azure,OU=Hardware,DC=ihc,DC=co,DC=nz",
#         "User": "ihc\\svc_ADjoin",
#         "Restart": "true",
#         "Options": "3"
#     }
# SETTINGS

#   protected_settings = <<PROTECTED_SETTINGS
#     {
#         "Password": "${var.ad_join_password}"
#     }
# PROTECTED_SETTINGS
# }

# ##########################################################
# ## Install Roles on VM
# ##########################################################
# resource "azurerm_virtual_machine_extension" "ad-tools" {
#   count                = var.vm_count
#   name                 = "install-adtools"
#   virtual_machine_id   = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.9"
#   depends_on           = [azurerm_windows_virtual_machine.vm]

#   settings = <<SETTINGS
#     { 
#       "commandToExecute": "powershell Add-WindowsFeature -Name NPAS;Add-WindowsFeature -Name RSAT-NPAS"
#     } 
# SETTINGS
# }
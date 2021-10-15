
#################################################
## TERRAFORM CLOUD DETAILS (Only used for remote apply with Terraform Cloud)
#################################################
terraform {
  backend "remote" {
    organization = "haszbro"
    workspaces {
      name = "haszbroterraform"
    }
  }
    required_providers {
    azurerm = "2.50"
  }
}

provider "azurerm" {
  subscription_id = "b23bbcd9-8ee7-4fcf-944d-c4589f4365de"
  features {}
}

###################################################
## RESOURCE GROUP MODULE(S)
###################################################
module "resourcegr1" {
  source              = ".//modules/az_resource" ### Logical path to module files
  location            = var.default_location
  resource_group_name = var.resource_group1_name
  ### TAGS - Referenced by other modules below
  tag_project     = "haszbro testing"
  tag_environment = "TEST/DEV"
  tag_comments    = "VMs for Ed testing Terraform"
}

###################################################
## NETWORK MODULE(S)
###################################################
module "network1" {
  source = ".//modules/az_network"
  location = module.resourcegr1.location
  network_RG_name = var.network_RG_name
  network_vnet_name = var.network_vnet_name
  network_subnet_name = var.network_subnet_name
}

###################################################
## WINDOWS VM MODULE
###################################################
module "azvm1" {
  source               = ".//modules/az_windows_vm"
  location             = module.resourcegr1.location
  resource_group_name  = module.resourcegr1.resource_group_name
  vm_count             = 2
  vm_name              = "prd-raid-0"
  vm_size              = "Standard_D2s_v3"
  storage_account_type = "StandardSSD_LRS"
  data_disk_size       = "100"
  data_disk_type       = "StandardSSD_LRS"
  vm_subnet            = module.network1.subnet1_id
  #avset_id             = module.azavset.avset_id
  #ip_address_range    = "10.200.0."
  vm_admin_username    = var.vm_admin_username
  vm_admin_password    = var.vm_admin_password
  ad_join_password     = var.ad_join_password
  #workspace_key        = var.workspace_key
  ### AZURE PUBLIC IMAGE
  vm_storage_img_publisher = "MicrosoftWindowsServer"
  vm_storage_img_offer     = "WindowsServer"
  vm_storage_img_sku       = "2019-datacenter-gensecond"
  ### TAGS
  tag_project     = module.resourcegr1.tag_project
  tag_environment = module.resourcegr1.tag_environment
  tag_comments    = module.resourcegr1.tag_comments
  tag_deployment  = module.resourcegr1.tag_deployment
}
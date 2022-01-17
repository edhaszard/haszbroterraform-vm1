
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
module "vm_resourcegr" {
  source              = ".//modules/az_resource" ### Logical path to module files
  location            = var.default_location
  resource_group_name = var.resource_group1_name
  ### TAGS - Referenced by other modules below
  tag_project     = "haszbro testing"
  tag_environment = "TEST/DEV"
  tag_comments    = "VMs for Ed testing Terraform"
  tag_deployment = "Just testing!"
}

## Resource group module for Azure Site Recovery resource group

module "asr_resourcegr" {
  source              = ".//modules/az_resource" ### Logical path to module files
  location            = var.asr_location
  resource_group_name = var.asr_rg_name
  ### TAGS - Referenced by other modules below
  tag_project     = "haszbro testing"
  tag_environment = "TEST/DEV"
  tag_comments    = "ASR for Ed testing Terraform"
  tag_deployment = "Just testing!"
}

###################################################
## NETWORK MODULE(S)
###################################################
module "network1" {
  source = ".//modules/az_network"
  location = module.vm_resourcegr.location
  network_RG_name = var.network_RG_name
  network_vnet_name = var.network_vnet_name
  network_subnet_name = var.network_subnet_name
  tag_project     = module.vm_resourcegr.tag_project
  tag_environment = module.vm_resourcegr.tag_environment
  tag_comments    = module.vm_resourcegr.tag_comments
}

###################################################
## MANAGED DISK MODULE(S)
###################################################

module "mdisk_1" {
  source = ".//modules/az_managed_disk" # path to module
  location = module.vm_resourcegr.location
  resource_group_name = module.vm_resourcegr.rg_name
  mdisk_name = "${var.vm_name}-${var.mdisk_1_name}"
  storage_account_type = var.storage_account_type
  mdisk_create_option = "Empty"
  mdisk_size_gb = var.mdisk_1_size
}

module "mdisk_2" {
  source = ".//modules/az_managed_disk" # path to module
  location = module.vm_resourcegr.location
  resource_group_name = module.vm_resourcegr.rg_name
  mdisk_name = "${var.vm_name}-${var.mdisk_2_name}"
  storage_account_type = var.storage_account_type
  mdisk_create_option = "Empty"
  mdisk_size_gb = var.mdisk_2_size
}

###################################################
## WINDOWS VM MODULE
###################################################
module "azvm1" {
  source               = ".//modules/az_windows_vm"
  location             = module.vm_resourcegr.location
  resource_group_name  = module.vm_resourcegr.rg_name
  vm_name              = var.vm_name
  vm_size              = "Standard_D2s_v3"
  storage_account_type = "StandardSSD_LRS"
  data_disk_size       = "100"
  data_disk_type       = "StandardSSD_LRS"
  vm_subnet            = module.network1.subnet1_id
  vm_public_ip = module.network1.public_ip_id
  mdisk_1_id = module.mdisk_1.mdisk_id
  mdisk_2_id = module.mdisk_2.mdisk_id
  #avset_id             = module.azavset.avset_id
  #ip_address_range    = "10.200.0."
  vm_admin_username    = var.vm_admin_username
  vm_admin_password    = var.vm_admin_password
  #ad_join_password     = var.ad_join_password
  #workspace_key        = var.workspace_key
  ### AZURE PUBLIC IMAGE
  vm_storage_img_publisher = "MicrosoftWindowsServer"
  vm_storage_img_offer     = "WindowsServer"
  vm_storage_img_sku       = "2019-datacenter-gensecond"
  ### TAGS
  tag_project     = module.vm_resourcegr.tag_project
  tag_environment = module.vm_resourcegr.tag_environment
  tag_comments    = module.vm_resourcegr.tag_comments
  tag_deployment  = module.vm_resourcegr.tag_deployment
}

###################################################
## AZURE SITE RECOVERY VAULT MODULE
###################################################
module "vault1" {
  source = ".//modules/az_recovery_vault"
  VM_rg = var.resource_group1_name
  ASR_rg = var.asr_rg_name
}
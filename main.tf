
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
# RG variables

variable "resource_group1_name" {
  default = "VMresourceGroup1"
}

variable "default_location" {
  default = "australiaeast"
}

# Network variables

variable "network_RG_name" {
  default = "mytestTFResourceGroup2" # existing
}

variable "network_vnet_name" {
  default = "1sttestVnet" # existing
}

variable "network_subnet_name" {
  default = "vnet1sub2" # existing
}

# The following variables are set in the Terraform Cloud workspace but need to be defined here

variable "vm_admin_username"{
  description = "VM local admin username"
  default = ""
}

variable "vm_admin_password"{
  description = "VM local admin password"
  default = ""
}
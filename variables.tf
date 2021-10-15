# RG variables

variable "resource_group1_name" {
  default = "VMresourceGroup1"
}

variable "default_location" {
  default = "australiaeast"
}

# Network variables

variable "network_RG_name" {
  default = "mytestTGResourceGroup2" # existing
}

variable "network_vnet_name" {
  default = "1sttestVnet" # existing
}

variable "network_subnet_name" {
  default = "vnet1sub2"
}
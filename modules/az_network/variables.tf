variable "vnet_name" {
  description = "Name of the vnet to create"
}

variable "network_resource_group_name" {
  description = "Vnet resource group"
}

variable "location" {
  }

variable "vnet_addr_space" {
}

variable "subnet1_name" {
  description = "subnet 1 name."
}

variable "subnet1_prefix" {
  description = "subnet 1 prefix"
}

variable "subnet2_name" {
  description = "subnet 2 name."
}

variable "subnet2_prefix" {
  description = "subnet 2 prefix"
}
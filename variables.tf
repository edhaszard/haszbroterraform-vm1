# VM RG variables

variable "resource_group1_name" {
  default = "VMresourceGroup1"
}

variable "default_location" {
  default = "australiaeast"
}

# ASR RG variables

variable "asr_location" {
  default = "westus"
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

# vm variables
variable "vm_name" {
  description = "The VM's name"
  default = "haszbro-test-vm"  
}

# managed disk variables
# mdisk 1
variable "mdisk_1_name" {
  description = "Name for the Managed Disk"
  default = "Data1"  
}

variable "mdisk_1_size" {
  description = "Size of the Managed Disk in GB"
  default = "1024"  
}

# mdisk 2
variable "mdisk_2_name" {
  description = "Name for the Managed Disk"
  default = "Data2"  
}

variable "mdisk_2_size" {
  description = "Size of the Managed Disk in GB"
  default = "128"  
}

variable "storage_account_type" {
  description = "Storage account type for the Managed Disk"
  default = "StandardSSD_LRS"  
}
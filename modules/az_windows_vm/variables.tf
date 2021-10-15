variable "resource_group_name" {
  description = "Resource Group Name"
}

variable "vm_subnet" {
  description = "Subnet ID"
}

# variable "ip_address_range" {
# }

# variable "avset_id" {
  
# }

variable "location" {
  description = "Location"
}

variable "storage_account_type" {
}

variable "data_disk_size" {
  description = "Disk Size (in GBs)"
}

variable "data_disk_type" {
  description = "Disk Storage Type"
}

variable "vm_name" {
  description = "Virtual Machine Name"
}

variable "vm_count" {
  description = "Virtual Machine Count"
}

variable "vm_admin_username" {
  description = "VM Admin Username"
}

variable "vm_admin_password" {
  description = "VM Admin Password"
}

variable "ad_join_password" {
  description = ""
}

# variable "workspace_key" {
#   description = "Log analytics workspace key"
# }

variable "vm_size" {
  description = "VM Size"
}

variable "vm_storage_img_offer" {
  description = "VM Storage Image Offer"
}

variable "vm_storage_img_publisher" {
  description = "VM Storage Image Publisher"
}

variable "vm_storage_img_sku" {
  description = "VM Storage Image SKU"
}

# variable "custom_image_name" {
# }

# variable "custom_image_resource_group_name" {
# }

#variable "vm_storage_os_name" {
# description = "VM Storage OS Disk Name"
#}

variable "tag_project" {
}
variable "tag_environment" {
}
variable "tag_comments" {
}
variable "tag_deployment" {
}
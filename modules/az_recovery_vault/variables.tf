#variable "VM_rg" {
  #description = "name of the resource group containing the VM"
#}

#variable "ASR_rg" {
#  description = "name of the resource group for ASR"
#}

variable "ASR_rg_location" {
  description = "The location of the ASR resource group"
}

variable "ASR_sku" {
  description = "SKU for the vault"
}
variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "vm_ids" {
  description = "List of VM IDs to associate with the load balancer"
  type        = list(string)
  default     = []
}

variable "location" {
  type        = string
}

variable "humber_id"{
  type = string
}

variable "tags" {
  type = map(string)
}
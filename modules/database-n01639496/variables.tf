
variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "db_admin_username" {
  type        = string
}

variable "db_admin_password" {
  type        = string
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "humber_id" {
  type = string
}

variable "tags" {
  type = map(string)
}


variable "humber_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "subnet_id" {
  type = string
}

variable "storage_account_uri" {
  type = string
}

variable "windows_admin_username" {
  type    = string
  default = "n01639496"
}

variable "windows_admin_password" {
  type    = string
  default = "Malan@212"
}

variable "windows_vm_count" {
  type    = number
  default = 1
}

variable "tags" {
  type = map(string)
}


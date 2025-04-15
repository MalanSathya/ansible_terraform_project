variable "humber_id" {
  type    = string
  default = "n01639496"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "linux_admin_username" {
  type    = string
  default = "n01639496"
}

variable "windows_admin_username" {
  type    = string
  default = "n01639496"
}

variable "windows_admin_password" {
  type    = string
  default = "Malan@212"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "linux_vm_count" {
  type    = number
  default = 2
}

variable "windows_vm_count" {
  type    = number
  default = 0
}

variable "tags" {
  type = map(string)
  default = {
    Assignment     = "CCGC 5502 Automation Project"
    Name           = "Malan.VenkatesanSathyanaarayan"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}


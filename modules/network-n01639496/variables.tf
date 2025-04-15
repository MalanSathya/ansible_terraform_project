
variable "resource_group_name" {
  type = string
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


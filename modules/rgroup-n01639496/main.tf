
resource "azurerm_resource_group" "rgroup" {
  name     = "${var.humber_id}-RG"
  location = var.location
  tags = var.tags
}


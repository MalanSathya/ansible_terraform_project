
resource "azurerm_postgresql_server" "db_instance" {
  name                = "${var.humber_id}-db"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = false

  administrator_login    = var.db_admin_username
  administrator_login_password = var.db_admin_password

  version              = "11"
  ssl_enforcement_enabled = true

  tags = var.tags
}


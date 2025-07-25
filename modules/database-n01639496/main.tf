resource "azurerm_postgresql_flexible_server" "db_instance" {
  name                   = "n01639496-db"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  zone                   = "1"
  backup_retention_days  = 7
  geo_redundant_backup_enabled = false

  authentication {
    password_auth_enabled = true
  }

  tags = var.tags
}


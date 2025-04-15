
resource "azurerm_managed_disk" "datadisk" {
  count                = length(var.vm_ids)
  name                 = "datadisk${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attachment" {
  count              = length(var.vm_ids)
  managed_disk_id    = azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id = element(var.vm_ids, count.index)
  lun                = count.index + 1
  caching            = "ReadWrite"
  create_option      = "Attach"
}


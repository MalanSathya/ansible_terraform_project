
resource "azurerm_availability_set" "avset" {
  name                = "${var.humber_id}-windows-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count = 2
  platform_update_domain_count = 5
  managed             = true
  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.windows_vm_count
  name                = "${var.humber_id}-w-vm${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  ip_configuration {
    name                          = "${var.humber_id}-w-vm${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.windows_vm_count
  name                = "${var.humber_id}-w-vm${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                = "Standard_B1ms"
  availability_set_id = azurerm_availability_set.avset.id
  admin_username        = var.windows_admin_username
  admin_password        = var.windows_admin_password

  os_disk {
    name                 = "${var.humber_id}-w-vm${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                     = var.windows_vm_count
  name                      = "${var.humber_id}-w-vm${count.index + 1}-antimalware"
  virtual_machine_id        = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                 = "Microsoft.Azure.Security"
  type                      = "IaaSAntimalware"
  type_handler_version      = "1.5"
  auto_upgrade_minor_version = true
  tags = var.tags

  settings = <<SETTINGS
{
  "AntimalwareEnabled": true,
  "RealtimeProtectionEnabled": true,
  "ScheduledScanSettings": {
    "isEnabled": true,
    "day": 1,
    "time": 120,
    "scanType": "Quick"
  },
  "Exclusions": {
    "Extensions": ".log;.ldf",
    "Paths": "D:\\\\IISLogs;D:\\\\Temp",
    "Processes": "MsSense.exe;svchost.exe"
  }
}
SETTINGS

  depends_on = [
    azurerm_windows_virtual_machine.vm
  ]
}



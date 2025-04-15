
resource "azurerm_availability_set" "avset" {
  name                = "${var.humber_id}-linux-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count = 2
  platform_update_domain_count = 5
  managed             = true
  tags = var.tags
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = toset([for i in range(1, var.linux_vm_count + 1) : tostring(i)])
  name                = "${var.humber_id}-c-vm${each.value}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.humber_id}-c-vm${each.value}"
  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = toset([for i in range(1, var.linux_vm_count + 1) : tostring(i)])
  name                = "${var.humber_id}-c-vm${each.value}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  ip_configuration {
    name                          = "${var.humber_id}-c-vm${each.value}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.linux_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = toset([for i in range(1, var.linux_vm_count + 1) : tostring(i)])
  name                = "${var.humber_id}-c-vm${each.value}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  size                = "Standard_B1ms"
  availability_set_id = azurerm_availability_set.avset.id
  admin_username        = var.linux_admin_username

  os_disk {
    name                 = "${var.humber_id}-c-vm${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-DAILY-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.ssh_public_key_path)
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = toset([for i in range(1, var.linux_vm_count + 1) : tostring(i)])
  name                       = "network-watcher-agent-linux-${each.value}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = toset([for i in range(1, var.linux_vm_count + 1) : tostring(i)])
  name                       = "azure-monitor-linux-agent-${each.value}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags = var.tags
}


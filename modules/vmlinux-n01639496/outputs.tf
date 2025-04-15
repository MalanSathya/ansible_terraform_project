output "linux_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.name]
}

output "linux_private_ips" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.private_ip_address]
}

output "linux_public_ips" {
  description = "List of public IP addresses of the Linux VMs"
  value       = [for vm in azurerm_public_ip.linux_pip : vm.ip_address]
}

output "linux_fqdns" {
  value = [for vm in azurerm_public_ip.linux_pip : vm.domain_name_label]
}

output "linux_vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.id]
}


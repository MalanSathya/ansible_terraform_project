# Generate Ansible inventory from Terraform
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    vm_ips         = [for k in keys(azurerm_public_ip.linux_pip) : azurerm_public_ip.linux_pip[k].ip_address]
    vm_hostnames   = [for k in keys(azurerm_linux_virtual_machine.vm) : azurerm_linux_virtual_machine.vm[k].name]
    vm_fqdns       = [for k in keys(azurerm_public_ip.linux_pip) : azurerm_public_ip.linux_pip[k].fqdn]
    admin_username = var.linux_admin_username
  })
  filename = "${path.root}/ansible/inventory.ini"
}

# Wait until SSH is available for each VM
resource "null_resource" "wait_for_ssh" {
  for_each = azurerm_linux_virtual_machine.vm

  provisioner "remote-exec" {
    inline = ["echo 'SSH available on ${each.key}'"]

    connection {
      type        = "ssh"
      user        = var.linux_admin_username
      private_key = file(replace(var.ssh_public_key_path, ".pub", ""))
      host        = azurerm_public_ip.linux_pip[each.key].ip_address
    }
  }

  depends_on = [
    azurerm_linux_virtual_machine.vm,
    azurerm_public_ip.linux_pip
  ]
}

# Execute Ansible playbook after SSH is ready
resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "cd ${path.root}/ansible && ansible-playbook -i inventory.ini n01639496-playbook.yaml"
  }

  depends_on = [
    local_file.ansible_inventory,
    null_resource.wait_for_ssh
  ]
}
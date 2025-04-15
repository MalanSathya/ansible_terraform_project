output "load_balancer_name" {
  value = azurerm_lb.loadbalancer.name
}

output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_pip.ip_address
}

output "loadbalancer_fqdn" {
  value = azurerm_public_ip.lb_pip.fqdn
}
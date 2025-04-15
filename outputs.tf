output "all_outputs" {
  value = {
    resource_group_name          = module.rgroup-n01639496.resource_group_name
    virtual_network_name         = module.network-n01639496.vnet_name
    subnet_name                  = module.network-n01639496.subnet_name
    log_analytics_workspace_name = module.common-n01639496.log_analytics_workspace_name
    recovery_services_vault_name = module.common-n01639496.recovery_services_vault_name
    storage_account_name         = module.common-n01639496.storage_account_name
    linux_hostnames              = module.vmlinux-n01639496.linux_hostnames
    linux_fqdns                  = module.vmlinux-n01639496.linux_fqdns
    linux_private_ips            = module.vmlinux-n01639496.linux_private_ips
    linux_public_ips             = module.vmlinux-n01639496.linux_public_ips
    windows_hostnames            = module.vmwindows-n01639496.windows_hostnames
    windows_fqdns                = module.vmwindows-n01639496.windows_fqdns
    windows_private_ips          = module.vmwindows-n01639496.windows_private_ips
    windows_public_ips           = module.vmwindows-n01639496.windows_public_ips
    load_balancer_name           = module.loadbalancer-n01639496.load_balancer_name
    database_name                = module.database-n01639496.database_instance_name
  }
}


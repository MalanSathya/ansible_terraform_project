[linux_vms]
%{ for i, ip in vm_ips ~}
${vm_hostnames[i]} ansible_host=${ip} ansible_user=${admin_username} ansible_ssh_private_key_file=~/.ssh/id_rsa fqdn=${vm_fqdns[i]}
%{ endfor ~}

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
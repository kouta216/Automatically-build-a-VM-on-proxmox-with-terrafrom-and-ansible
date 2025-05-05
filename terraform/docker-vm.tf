resource "proxmox_vm_qemu" "docker-vm" {
  name        = var.vm_name
  target_node = var.pm_node_name
  clone       = var.vm_template # cloud-init対応のVMテンプレート
  cores       = 2
  sockets     = 1
  memory      = 4096
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  agent       = 1
  qemu_os     = "l26" 
  
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "50G"  
        }
      }
     }

    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = var.vm_bridge
    id     = 0
    firewall = true
  }
  serial {
    id   = 0
    type = "socket"
  }

  ciuser      = var.vm_username
  cipassword  = var.vm_password
  searchdomain = var.vm_searchdomain
  nameserver = var.vm_nameserver
  ipconfig0   = "ip=${var.vm_ip}/${var.vm_cidr},gw=${var.vm_gateway}"
  sshkeys     = file("../.ssh/id_rsa.pub")

}

resource "null_resource" "wait_for_ssh" {
depends_on = [proxmox_vm_qemu.docker-vm]

  connection {
    type        = "ssh"
    host        = var.vm_ip
    user        = var.vm_username
    password    = var.vm_password 
    private_key = file("../.ssh/id_rsa")
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo VM is reachable via SSH"
    ]
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [null_resource.wait_for_ssh]

  content  = <<-EOT
[docker-vms]
${var.vm_name} ansible_host=${var.vm_ip} ansible_ssh_user=${var.vm_username} ansible_ssh_password=${var.vm_password} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

EOT
  filename = "../ansible/inventory/hosts.ini"
}

resource "null_resource" "copy_ansible_files" {
  depends_on = [local_file.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      scp -i ${var.ssh_private_key_path} -o StrictHostKeyChecking=no -r ../ansible ${var.ansible_server_user}@${var.ansible_server_ip}:/home/${var.ansible_server_user}/
    EOT
  }
}

resource "null_resource" "run_ansible" {
  depends_on = [null_resource.copy_ansible_files]

  connection {
    type        = "ssh"
    user        = var.ansible_server_user
    private_key = file(var.ssh_private_key_path)
    host        = var.ansible_server_ip
    timeout     = "5m"
    bastion_host = null
  }

  provisioner "remote-exec" {
    inline = [
      "/usr/bin/ansible-playbook -vvvv -i /home/${var.ansible_server_user}/ansible/inventory/hosts.ini /home/${var.ansible_server_user}/ansible/site.yml",
      "chmod -R 777 /home/${var.ansible_server_user}/ansible",
      "rm -rf /home/${var.ansible_server_user}/ansible"
    ]
  }
}


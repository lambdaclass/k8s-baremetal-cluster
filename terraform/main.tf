provider "scaleway" {
  organization_id   = var.organization_id
  secret_key        = var.secret_key
  region            = var.region
  zone              = var.zone
}

resource "scaleway_account_ssh_key" "ssh_key" {
  name          = var.ssh_name
  public_key    = var.ssh_key
}

data "scaleway_image" "ubuntu" {
  architecture  = var.arch
  name          = var.ubuntu_version
}

data "template_file" "ansible_inventory_tpl" {
  template = file("terraform/inventory.tpl")

  vars = {
    names_ips = join("\n", formatlist("%[1]s ansible_host=%[2]s access_ip=%[2]s ip=%[3]s", 
                                                concat(scaleway_instance_server.k8s_master.*.name,
                                                      scaleway_instance_server.k8s_worker.*.name),
                                                concat(scaleway_instance_server.k8s_master.*.public_ip,
                                                      scaleway_instance_server.k8s_worker.*.public_ip)
                                                      ),
                                                concat(scaleway_instance_server.k8s_master.*.private_ip,
                                                      scaleway_instance_server.k8s_worker.*.private_ip)
                                                      )
    master_names = join("\n", scaleway_instance_server.k8s_master.*.name)
    worker_names = join("\n", scaleway_instance_server.k8s_worker.*.name)
  }
}

resource "local_file" "ansible_inventory" {
  content   = data.template_file.ansible_inventory_tpl.rendered
  filename  = "inventory/inventory.ini"
}


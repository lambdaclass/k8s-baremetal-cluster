resource "scaleway_instance_ip" "k8s_master_ip" {
  zone = var.zone
}

resource "scaleway_instance_server" "k8s_master" {
  count       = var.masters
  name        = "${var.master_hostname}-${count.index + 1}"
  image       = data.scaleway_image.ubuntu.id
  type        = var.instance_type
  depends_on  = [scaleway_account_ssh_key.ssh_key]
  zone        = var.zone
}


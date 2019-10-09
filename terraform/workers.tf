resource "scaleway_instance_ip" "k8s_worker_ip" {
  count = var.workers
  zone  = var.zone
}

resource "scaleway_instance_server" "k8s_worker" {
  count       = var.workers
  name        = "${var.worker_hostname}-${count.index + 1}"
  image       = data.scaleway_image.ubuntu.id
  type        = var.instance_type
  depends_on  = [scaleway_account_ssh_key.ssh_key]
  zone        = var.zone
}


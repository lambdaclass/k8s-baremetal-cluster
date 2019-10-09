output "k8s_master_public_ip" {
  value = concat(
      scaleway_instance_server.k8s_master.*.name,
      scaleway_instance_server.k8s_master.*.public_ip,
  )
}

output "worker_public_ips" {
  value = concat(
    scaleway_instance_server.k8s_worker.*.name,
    scaleway_instance_server.k8s_worker.*.public_ip,
  )
}

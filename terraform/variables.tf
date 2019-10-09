variable "organization_id" {
}

variable "secret_key" {
}

variable "region" {
  default = "fr-par"
}

variable "zone" {
  default = "fr-par-1"
}

variable "ssh_key" {
}

variable "ssh_name" {
}

variable "arch" {
  default     = "x86_64"
  description = "Values: arm arm64 x86_64"
}

variable "instance_type" {
  default     = "C2S"
  description = "Baremetal instance type"
}

variable "ubuntu_version" {
  default = "Ubuntu Bionic"
  description = <<EOT

For arm, choose from:
  - Ubuntu Xenial

For x86_64, choose from:
  - Ubuntu Xenial
  - Ubuntu Bionic

Notes:
  - kubernetes only has xenial packages for debian
  - currently arm is not working with ubuntu bionic (kubeadm init hangs)

EOT
}

variable "masters" {
  default = 1
}
variable "workers" {
  default = 2
}

variable "master_hostname" {
  default = "kube-master"
}

variable "worker_hostname" {
  default = "kube-worker"
}

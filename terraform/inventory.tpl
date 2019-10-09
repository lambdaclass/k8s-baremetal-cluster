[all]
${names_ips}

[kube-masters]
${master_names}

[kube-workers]
${worker_names}

[etcd]
${master_names}

[k8s-cluster:children]
kube-masters
kube-workers
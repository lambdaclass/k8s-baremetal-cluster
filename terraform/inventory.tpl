[all]
${names_ips}

[kube-master]
${master_names}

[kube-node]
${master_names}
${worker_names}

[etcd]
${master_names}

[k8s-cluster:children]
kube-master
kube-node

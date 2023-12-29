# output "external_ip_publicvm" {
#   value = yandex_compute_instance.publicvm.network_interface.0.nat_ip_address
# }

output "k8s_cluster_id" {
  value = yandex_kubernetes_cluster.k8s-regional.id
}



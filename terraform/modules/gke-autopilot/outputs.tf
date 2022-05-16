output "cluster_name" {
  value = module.gke.name
}

output "cluster_id" {
  value = module.gke.cluster_id
}

output "network_name" {
  value = module.gcp-network.network_name
}
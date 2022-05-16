output "cluster_id" {
  value = module.gke_autopilot.cluster_id
}

output "cluster_name" {
  value = module.gke_autopilot.cluster_name
}

output "network_name" {
  value = module.gke_autopilot.network_name
}

output "cloudsql_instance_name" {
  value = module.postgresql-db.instance_name
}

output "project_bucket_name" {
  description = "The name of the projec's bucket"
  value       = data.google_storage_bucket.project_bucket.name
}

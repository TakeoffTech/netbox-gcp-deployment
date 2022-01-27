output "cluster_id" {
  value = split("/", module.gke_autopilot.cluster.id)[5]
}

output "cloudsql_instance_name" {
  value = module.postgresql-db.instance_name
}

output "project_bucket_name" {
  description = "The name of the projec's bucket"
  value       = data.google_storage_bucket.project_bucket.name
}

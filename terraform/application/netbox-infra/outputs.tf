output "cluster_id" {
  value = split("/", module.gke_autopilot.cluster.id)[5]
}

output "cloudsql_instance_name" {
  value = module.postgresql-db.instance_name
}

output "project_bucket_name" {
  description = "The name of the projec's bucket"
  value       = google_storage_bucket.project_bucket.name
}

output "project_bucket_self_link" {
  value       = google_storage_bucket.project_bucket.self_link
  description = "Project's bucket selfLink"
}

output "project_bucket_url" {
  value       = google_storage_bucket.project_bucket.url
  description = "Project's bucket url"
}
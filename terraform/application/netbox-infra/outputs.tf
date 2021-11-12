output "cluster_id" {
  value = split("/", module.gke_autopilot.cluster.id)[5]
}

output "cloudsql_instance_name" {
  value = module.postgresql-db.instance_name
}
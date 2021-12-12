module "app-infra" {
  source = "../../modules/app-infra"

  project_id = var.project_id
  region = var.region

  cloudsql_instance_name = var.cloudsql_instance_name
  namespace = var.namespace

  bucket_force_destroy = true

}
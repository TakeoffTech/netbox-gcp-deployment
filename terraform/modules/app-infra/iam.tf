module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = local.name
  namespace  = var.namespace
  project_id = var.project_id
  roles      = ["roles/cloudsql.client", "roles/iam.serviceAccountTokenCreator"]
}
locals {
  cluster_name = "gke"
}

##### make sure APIs are enabled ######
resource "google_project_service" "default" {
  for_each           = toset(var.google_apis)
  provider           = google
  service            = each.value
  disable_on_destroy = false
}

##### Bucket to store terraform state
resource "google_storage_bucket" "project_bucket" {
  name                        = "${var.project_id}-state"
  project                     = var.project_id
  location                    = var.bucket_location
  labels                      = var.bucket_labels
  force_destroy               = var.bucket_force_destroy
  uniform_bucket_level_access = var.bucket_ula

  versioning {
    enabled = var.bucket_versioning
  }
}

##### Deploy GKE autopilot cluster #####
module "gke_autopilot" {
  source = "../../modules/gke_autopilot"

  name   = local.cluster_name
  region = var.region
}

module "postgresql-db" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version              = "8.0.0"
  name                 = "netbox-postgresql"
  random_instance_name = true
  database_version     = "POSTGRES_13"
  project_id           = var.project_id
  availability_type    = "REGIONAL"
  region               = var.region
  zone                 = "${var.region}-a"
  tier                 = "db-f1-micro"

  deletion_protection = false
  create_timeout      = "30m"

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    authorized_networks = []
  }

}

module "app-infra" {
  count  = var.gcloud_get_credentials ? 0 : 1
  source = "../../modules/app-infra"

  project_id             = var.project_id
  region                 = var.region
  cloudsql_instance_name = module.postgresql-db.instance_name
}

resource "null_resource" "kube_context" {
  count      = var.gcloud_get_credentials ? 1 : 0
  depends_on = [module.gke_autopilot]

  triggers = {
    cluster_name = local.cluster_name
    project_id   = var.project_id
    region       = var.region
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      gcloud container clusters get-credentials ${self.triggers.cluster_name} --region ${self.triggers.region} --project ${self.triggers.project_id}
    EOT
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      kubectl config delete-context gke_${self.triggers.project_id}_${self.triggers.region}_${self.triggers.cluster_name}
    EOT
  }
}

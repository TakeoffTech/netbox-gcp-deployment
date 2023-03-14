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

##### get bucket data for terraform state
data "google_storage_bucket" "project_bucket" {
  name = "${var.project_id}-state"
}

##### Deploy GKE autopilot cluster #####
module "gke_autopilot" {
  source = "../../modules/gke-autopilot"

  project_id = var.project_id
  name       = local.cluster_name
  region     = var.region
}

module "postgresql-db" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version              = "14.0.1"
  name                 = "netbox-postgresql"
  random_instance_name = true
  database_version     = "POSTGRES_13"
  project_id           = var.project_id
  availability_type    = "REGIONAL"
  region               = var.region
  zone                 = "${var.region}-a"
  tier                 = "db-custom-1-3840"

  deletion_protection = false
  create_timeout      = "30m"
  enable_default_db   = false
  enable_default_user = false

  ip_configuration = {
    allocated_ip_range  = null
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    authorized_networks = []
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "22:50"
    location                       = null
    point_in_time_recovery_enabled = true
    transaction_log_retention_days = null
    retained_backups               = 90
    retention_unit                 = "COUNT"
  }
}

module "app-infra" {
  count  = var.gcloud_get_credentials ? 0 : 1
  source = "../../modules/app-infra"

  gke_cluster_name       = module.gke_autopilot.cluster_name
  network_name           = module.gke_autopilot.network_name
  project_id             = var.project_id
  region                 = var.region
  cloudsql_instance_name = module.postgresql-db.instance_name
}

resource "null_resource" "kube_context" {
  count      = var.gcloud_get_credentials ? 1 : 0
  depends_on = [module.gke_autopilot]

  triggers = {
    always_run   = "${timestamp()}"
    cluster_name = module.gke_autopilot.cluster_id
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
      kubectl config delete-context gke_${self.triggers.project_id}_${self.triggers.region}_${self.triggers.cluster_name} || true
    EOT
  }
}

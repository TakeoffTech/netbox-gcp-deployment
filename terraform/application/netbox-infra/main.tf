locals {
  cluster_name = "gke"
}

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

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    authorized_networks = []
  }

}

resource "null_resource" "kube_context" {
  count = var.gcloud_get_credentials ? 1 : 0
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

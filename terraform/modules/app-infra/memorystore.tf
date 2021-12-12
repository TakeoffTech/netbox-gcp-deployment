locals {
  network_name = "${var.gke_cluster_name}-vpc"
}

module "memorystore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "4.1.0"

  name    = "netbox-memorystore"
  project = var.project_id
  enable_apis = true

  transit_encryption_mode = "DISABLED"
  authorized_network      = data.google_compute_network.redis-network.id
}

data "google_compute_network" "redis-network" {
  name = local.network_name
}
locals {
  network_name = "${var.gke_cluster_name}-vpc"
}

module "memorystore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "~> 4.3"

  name    = "netbox-memorystore"
  project = var.project_id

  transit_encryption_mode = "DISABLED"
  authorized_network      = data.google_compute_network.redis-network.id
}

data "google_compute_network" "redis-network" {
  name = local.network_name
}
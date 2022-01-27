resource "google_container_cluster" "cluster" {
  name             = var.name
  location         = var.region
  enable_autopilot = true
  network          = google_compute_network.vpc.name
  node_config {
    service_account = local.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
  vertical_pod_autoscaling {
    enabled = true
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "public"
    }
  }
  release_channel {
    channel = "REGULAR"
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
  # This is where Dataplane V2 is enabled.
  datapath_provider = var.enable_dataplane_v2 ? "ADVANCED_DATAPATH" : "DATAPATH_PROVIDER_UNSPECIFIED"
}
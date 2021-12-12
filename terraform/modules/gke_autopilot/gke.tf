resource "google_container_cluster" "cluster" {
  name             = var.name
  location         = var.region
  enable_autopilot = true
  network          = google_compute_network.vpc.name

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
    channel = "STABLE"
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}
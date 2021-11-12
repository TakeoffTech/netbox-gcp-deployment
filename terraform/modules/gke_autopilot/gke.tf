resource "google_container_cluster" "cluster" {
  name     = var.name
  location = var.region

  enable_autopilot = true

  vertical_pod_autoscaling {
    enabled = true
  }
}

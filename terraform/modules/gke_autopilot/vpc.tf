# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = "true"
}

# Router
resource "google_compute_router" "router" {
  name    = "${var.name}-router"
  network = google_compute_network.vpc.name
}

# NAT
resource "google_compute_router_nat" "outbound-nat" {
  name                               = "${var.name}-router-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

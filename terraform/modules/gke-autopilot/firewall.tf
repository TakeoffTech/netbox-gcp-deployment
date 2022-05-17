# fixing issue: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/1230
resource "google_compute_firewall" "master_webhooks" {
  name        = "gke-${substr(var.name, 0, min(25, length(var.name)))}-webhooks"
  description = "Managed by terraform gke-autopilot module: Allow master to hit pods for admission controllers/webhooks"
  network     = module.gcp-network.network_name
  priority    = 900
  direction   = "INGRESS"

  source_ranges = [var.master_ipv4_cidr_block]
  #target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "tcp"
    ports    = var.firewall_inbound_ports
  }


}
locals {
  cluster_endpoint_for_nodes = var.master_ipv4_cidr_block
  cluster_network_tag        = "gke-${var.name}"
}
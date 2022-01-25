variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "name" {
  description = "Name of GKE cluster"
  type        = string
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
  default     = "172.16.0.0/28"
}

variable "enable_dataplane_v2" {
  description = "Enable dataplane v2"
  type        = bool
  default     = true
}

variable "firewall_priority" {
  type        = number
  description = "Priority rule for firewall rules"
  default     = 1000
}

variable "firewall_inbound_ports" {
  type        = list(string)
  description = "List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied."
  default     = ["8443", "9443", "15017"]
}
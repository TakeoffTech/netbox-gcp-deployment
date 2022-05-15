variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "name" {
  description = "Base name of GKE cluster and resources"
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

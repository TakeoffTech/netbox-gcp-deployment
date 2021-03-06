variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}
variable "gke_cluster_name" {
  type    = string
  default = "gke"
}

variable "network_name" {
  description = "The VPC name to allow connections to memstore"
  type        = string
  default     = "gke-network"
}

variable "cloudsql_instance_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = ""
}

### variable to setup DNS
variable "dns_project_id" {
  description = "The project ID where your managed zone is hosted in (defaults to project_id)"
  type        = string
  default     = ""
}

variable "managed_zone" {
  description = "Google managed zone to create records"
  type        = string
  default     = ""
}

variable "enable_auth" {
  description = "Create vouch proxy dns record and okta application"
  type        = bool
  default     = true
}

### variables for OKTA configuration
variable "okta_org_name" {
  description = "Org Name for OKTA"
  type        = string
}

variable "okta_base_url" {
  description = "Okta base url"
  type        = string
  default     = "oktapreview.com"
}

variable "okta_resource_prefix" {
  description = "Prefix to add to Okta resources"
  type        = string
  default     = ""
}

variable "okta_assignment_group_name" {
  description = "Name of group to assign application to"
  type        = string
  default     = ""
}
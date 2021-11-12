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

variable "cloudsql_instance_name" {
  type = string
}

variable "namespace" {
  type    = string
}

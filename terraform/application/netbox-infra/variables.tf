variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "gcloud_get_credentials" {
  description = "Setup kubecontext with gcloud container clusters get-credentials"
  type = bool
  default = false
}

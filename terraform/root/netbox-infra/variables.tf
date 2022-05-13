variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
  default     = "us-central1"
}

variable "gcloud_get_credentials" {
  description = "Setup kubecontext with gcloud container clusters get-credentials"
  type        = bool
  default     = false
}

variable "google_apis" {
  type = list(string)
  default = [
    // General
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",

    // DNS
    //"dns.googleapis.com",

    // GKE + compute
    "compute.googleapis.com",
    "container.googleapis.com",

    // storage
    "storage-component.googleapis.com",
    "storage-api.googleapis.com",

    // Cloud SQL
    "sqladmin.googleapis.com",

    //redis
    "redis.googleapis.com"
  ]
}

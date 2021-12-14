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
  type = bool
  default = false
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

    // artifact registry
    "artifactregistry.googleapis.com",

    // storage
    "storage-component.googleapis.com",
    "storage-api.googleapis.com",

    // Cloud SQL
    "sqladmin.googleapis.com",

    //redis
    "redis.googleapis.com"
  ]
}

variable "bucket_location" {
  description = "The location for a GCS bucket to create (optional)"
  type        = string
  default     = "US"
}

variable "bucket_versioning" {
  description = "Enable versioning for a GCS bucket to create (optional)"
  type        = bool
  default     = true
}

variable "bucket_labels" {
  description = " A map of key/value label pairs to assign to the bucket (optional)"
  type        = map(string)
  default     = {}
}

variable "bucket_force_destroy" {
  description = "Force the deletion of all objects within the GCS bucket when deleting the bucket (optional)"
  type        = bool
  default     = false
}

variable "bucket_ula" {
  description = "Enable Uniform Bucket Level Access"
  type        = bool
  default     = true
}

variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
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
  default     = true
}

variable "bucket_ula" {
  description = "Enable Uniform Bucket Level Access"
  type        = bool
  default     = true
}

##### Bucket to store terraform state
resource "google_storage_bucket" "project_bucket" {
  name                        = "${var.project_id}-state"
  project                     = var.project_id
  location                    = var.bucket_location
  labels                      = var.bucket_labels
  force_destroy               = var.bucket_force_destroy
  uniform_bucket_level_access = var.bucket_ula

  versioning {
    enabled = var.bucket_versioning
  }
}

output "project_bucket_name" {
  description = "The name of the projec's bucket"
  value       = google_storage_bucket.project_bucket.name
}

output "project_bucket_self_link" {
  value       = google_storage_bucket.project_bucket.self_link
  description = "Project's bucket selfLink"
}

output "project_bucket_url" {
  value       = google_storage_bucket.project_bucket.url
  description = "Project's bucket url"
}
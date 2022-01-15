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
  default = ""
}

variable "random_bucket_name" {
  type        = bool
  description = "Sets random suffix at the end of the bucket name"
  default     = true
}

variable "bucket_force_destroy" {
  type        = bool
  description = "Enable Force destroy on the bucket"
  default     = false
}

### variable to setup DNS
variable "dns_project_id" {
  description = "The project ID where your managed_zone is hosted in"
  type        = string
  default     = ""
}
variable "managed_zone" {
  description = "Google managed zone to create records"
  type        = string
  default     = ""
}

variable "create_vouch_record" {
  description = "Create vouch proxy dns record"
  type        = bool
  default     = true
}

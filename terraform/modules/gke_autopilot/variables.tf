variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "name" {
  description = "Name of GKE cluster"
  type        = string 
}

variable "enable_dataplane_v2" {
  description = "Enable dataplane v2"
  type        = bool
  default     = true
}
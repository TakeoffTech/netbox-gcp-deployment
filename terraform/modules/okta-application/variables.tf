variable "name" {
  description = "The application name"
  type        = string
  default     = "netbox"
}

variable "enable_auth" {
  description = "Enable creating okta application"
  type = bool
  default = true
}

variable "redirect_uris" {
  description = "The Redirect uris for the app"
  type        = list(string)
  default     = []
}

variable "post_logout_redirect_uris" {
  description = "The post logout redirect uris for the app"
  type        = list(string)
  default     = []
}

variable "assignment_group_name" {
  description = "Name of group to assign application to"
  type        = string
  default     = "Everyone"
}

variable "org_name" {
  description = "Okta organization"
  type        = string
  default     = ""
}

variable "base_url" {
  description = "Okta base url"
  type        = string
  default     = "oktapreview.com"
}
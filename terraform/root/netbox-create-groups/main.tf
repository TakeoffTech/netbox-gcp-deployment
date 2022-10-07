terraform {
  required_providers {
    restapi = {
      source  = "KirillMeleshko/restapi"
      version = "1.17.0"
    }
  }
}

variable "netbox_host" {
  type = string
}

variable "netbox_api_token" {
  type = string
}

variable "groups" {
  type    = set(string)
  default = []
}

variable "readonly_group" {
  type    = string
  default = ""
}

provider "restapi" {
  alias                = "netbox"
  uri                  = "https://${var.netbox_host}/api"
  debug                = true
  write_returns_object = true
  insecure             = true

  headers = {
    Authorization = "Token ${var.netbox_api_token}"
  }
}

locals {
  objects_types     = jsondecode(file("${path.module}/object-types.json"))
  readonly_group_id = tonumber(restapi_object.create_group["${var.readonly_group}"].id)
  create_permission_object = {
    name         = "read-only",
    groups       = [local.readonly_group_id]
    actions      = ["view"]
    object_types = local.objects_types
  }
}

resource "restapi_object" "create_group" {
  for_each = var.groups
  provider = restapi.netbox
  path     = "/users/groups/"
  data     = "{ \"name\": \"${each.key}\" }"
}

resource "restapi_object" "create_permission" {
  count    = var.readonly_group != "" ? 1 : 0
  provider = restapi.netbox
  path     = "/users/permissions/"
  data     = jsonencode(local.create_permission_object)
}

resource "okta_app_oauth" "netbox" {
  count = var.enable_auth ? 1 : 0
  # label is the application name
  label                     = "${var.resource_prefix}${var.name}"
  type                      = "web"
  grant_types               = ["authorization_code"]
  redirect_uris             = var.redirect_uris
  post_logout_redirect_uris = var.post_logout_redirect_uris
  response_types            = ["code"]
  groups_claim {
    type        = "FILTER"
    name        = "groups"
    filter_type = "STARTS_WITH"
    value       = "${var.resource_prefix}${var.name}"
  }
  lifecycle {
    ignore_changes = [groups, users_excluded]
  }
}

data "okta_group" "assignment_group" {
  count = var.enable_auth ? 1 : 0
  name  = var.assignment_group_name
}

resource "okta_app_group_assignment" "netbox" {
  count    = var.enable_auth ? 1 : 0
  app_id   = okta_app_oauth.netbox[0].id
  group_id = data.okta_group.assignment_group[0].id
}

locals {
  groups = [
    for val in var.application_groups : {
      name        = "${var.resource_prefix}${var.name}-${val.basename}"
      description = "${title(var.name)} ${val.description}"
    }
  ]

  readonly_group    = one([for groupname in keys(okta_group.app_group) : groupname if length(regexall("-readonly", groupname)) > 0])
  readonly_group_id = lookup(okta_group.app_group["${local.readonly_group}"], "id", "unknown_group_id")
}

resource "okta_group" "app_group" {
  for_each = { for group in local.groups : group.name => group if var.enable_auth }

  name        = each.value.name
  description = each.value.description
}

resource "okta_group_rule" "netbox_readonly_group_rule" {
  count             = var.enable_auth ? 1 : 0
  name              = local.readonly_group
  status            = "ACTIVE"
  group_assignments = [local.readonly_group_id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "isMemberOfGroup(\"${data.okta_group.assignment_group[0].id}\")"
}
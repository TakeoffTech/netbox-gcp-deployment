resource "okta_app_oauth" "netbox" {
  count = var.enable_auth ? 1 : 0
  # label is the application name
  label                      = var.name
  type                       = "web"
  grant_types                = ["authorization_code"]
  redirect_uris              = var.redirect_uris
  post_logout_redirect_uris  = var.post_logout_redirect_uris
  response_types             = ["code"]
  groups_claim {
      type        = "FILTER"
      name        = "groups"
      filter_type = "STARTS_WITH"
      value       = "netbox"
  }
}

data "okta_group" "everyone" {
  count = var.enable_auth ? 1 : 0
  name = var.assignment_group_name
}

resource "okta_app_group_assignment" "netbox" {
  count = var.enable_auth ? 1 : 0
  app_id   = okta_app_oauth.netbox[0].id
  group_id = data.okta_group.everyone[0].id
}